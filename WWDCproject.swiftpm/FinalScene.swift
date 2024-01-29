//
//  FinalScene.swift
//  WWDCproject
//
//  Created by Leonardo Mesquita Alves on 18/01/24.
//

import SpriteKit
import SwiftUI

struct DisplayTest: View {
    
    var storyScene: SKScene {
        let scene = FinalScene()
        scene.size = SceneConfiguration.shared.size
        scene.scaleMode = .aspectFill
        return scene
    }
    
    var body: some View {
        SpriteView(scene: storyScene)
            .ignoresSafeArea()
            .statusBarHidden()
    }
}

#Preview {
    DisplayTest()
}

class FinalScene: SKScene {
    
    var rain: RainAnimation = RainAnimation()
    var textBox = GenericTextBox(title: "Fight time", text: "Now it’s time to confront your fears and come back to the beach! Use the deep breath tecnique that John learned!", nameOfTheSprite: .first)
    var grayBeach = SKSpriteNode(imageNamed: "Beach")
    var monsterV1 = SKSpriteNode(imageNamed: "Mv1")
    var shadow = SKSpriteNode(imageNamed: "Darkness")
    var shadow2 = SKSpriteNode(imageNamed: "Darkness")
    
    let badText1 = SKLabelNode(text: "You are a loser")
    let badText2 = SKLabelNode(text: "You don't deserve to be alive")
    let badText3 = SKLabelNode(text: "No one loves you")
    
    let darkness = SKShapeNode(rect: CGRect(x: -Int(SceneConfiguration.shared.size.width)/2, y: -Int(SceneConfiguration.shared.size.height)/2, width: Int(SceneConfiguration.shared.size.width), height: Int(SceneConfiguration.shared.size.height)))
    
    var breathTime1 = BreathMechanic()
    var breathTime2 = BreathMechanic()
    
    override func didMove(to view: SKView) {
        
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        monsterV1.anchorPoint = CGPoint(x: 1, y: 0)
        
        darkness.fillColor = .bgColor
        darkness.strokeColor = .clear
        
        grayBeach.setScale(0.3415)
        monsterV1.setScale(0.3415)
        shadow.setScale(0.8)
        
        monsterV1.position = CGPoint(x: 300, y: -120)
        
        shadow.alpha = 0.6
        shadow2.alpha = 0
        
        addChild(grayBeach)
        
        
        addChild(textBox)
        
        textBox.addAction { [self] in
            run(SKAction.wait(forDuration: 1)){ [self] in
                addChild(monsterV1)
                
//                monsterAnimation()
                addChild(shadow2)
//                monsterV1Attack()
                
                rain.alpha = 0
                
                addChild(rain)
                addChild(shadow)
                
                rain.run(SKAction.fadeAlpha(to: 1, duration: 2))
                shadow.run(SKAction.fadeAlpha(to: 1, duration: 2))
                
                addChild(darkness)
                darkness.zPosition = 10
                darkness.alpha = 0
            }
        }
        
        breathTime1.addAction {
            
        }
        
        breathTime2.addAction {
            
        }
    }
    
    func monsterAnimation(){
        monsterV1.run(SKAction.repeatForever(SKAction.sequence([
            SKAction.scaleY(to: 0.347, duration: 2),
            SKAction.scaleY(to: 0.35, duration: 1),
            SKAction.scaleY(to: 0.347, duration: 1),
            SKAction.scaleY(to: 0.3415, duration: 0.5),
            
        ])))
        
        monsterV1.run(SKAction.repeatForever(SKAction.sequence([
            SKAction.scaleX(to: 0.347, duration: 2),
            SKAction.scaleX(to: 0.35, duration: 1),
            SKAction.scaleX(to: 0.347, duration: 1),
            SKAction.scaleX(to: 0.3415, duration: 0.5),
        ])))
    }
    
    func monsterV1Attack(){
        
        run(SKAction.wait(forDuration: 3)){ [self] in
            badText1.zRotation = CGFloat.pi / 16
            badText2.zRotation = -CGFloat.pi / 32
            badText3.zRotation = CGFloat.pi / 16
            
            badText1.fontName = "Futura Bold"
            badText2.fontName = "Futura Bold"
            badText3.fontName = "Futura Bold"
            
            badText1.setScale(0)
            badText2.setScale(0)
            badText3.setScale(0)
            
            badText1.position = CGPoint(x: -200, y: 120)
            badText2.position = CGPoint(x: -200, y: 120)
            badText3.position = CGPoint(x: -200, y: 120)
            
            addChild(badText1)
            addChild(badText2)
            addChild(badText3)
            
            agressivesMessages()
        }
    }
    
    func agressivesMessages(){
        
        monsterV1.removeAllActions()
        
        let sequence = SKAction.sequence([
            SKAction.scaleY(to: 0.32, duration: 0.25),
            SKAction.scaleY(to: 0.3415, duration: 0.5),
            SKAction.wait(forDuration: 1.25),
        ])
        
        monsterV1.run(SKAction.repeatForever(SKAction.sequence([sequence, sequence, sequence])))
        
        let sequence2 = SKAction.sequence([
            SKAction.wait(forDuration: 0.5),
            SKAction.fadeAlpha(to: 0.8, duration: 0.1),
            SKAction.wait(forDuration: 1.1),
            SKAction.fadeAlpha(to: 0, duration: 0.3),
        ])
        
        let sequence3 = SKAction.sequence([
            SKAction.rotate(toAngle: CGFloat.pi / 8, duration: 0.1),
            SKAction.rotate(toAngle: -CGFloat.pi / 8, duration: 0.2),
        ])
        
        shadow2.run(SKAction.repeatForever(sequence2))
        shadow2.run(SKAction.repeatForever(sequence3))
        
        action(label: badText1, waitBefore: 0, waitAfter: 4, x: 300, y: -700)
        action(label: badText2, waitBefore: 2, waitAfter: 2, x: 100, y: -700)
        action(label: badText3, waitBefore: 4, waitAfter: 0, x: 300, y: -700)
        
        func action(label: SKLabelNode, waitBefore: Double, waitAfter: Double, x: CGFloat, y: CGFloat){
            
            let sequence1 = SKAction.sequence([
                SKAction.fadeAlpha(to: 0, duration: 0),
                SKAction.moveTo(x: -200, duration: 0),
                SKAction.moveTo(y: 120, duration: 0),
                SKAction.scale(to: 0, duration: 0),
            ])
            
            let sequence2 = SKAction.sequence([
                SKAction.fadeAlpha(to: 1, duration: 0),
                SKAction.scale(to: 5, duration: 2),
            ])
            
            label.run(SKAction.repeatForever(SKAction.sequence([
                SKAction.wait(forDuration: waitBefore),
                sequence2,
                SKAction.wait(forDuration: waitAfter),
            ])))
            label.run(SKAction.repeatForever(SKAction.sequence([
                SKAction.wait(forDuration: waitBefore),
                SKAction.moveBy(x: x, y: y, duration: 2),
                sequence1,
                SKAction.wait(forDuration: waitAfter),
            ])))
        }
    }
    
    func setRespiration(){
        
    }
}
