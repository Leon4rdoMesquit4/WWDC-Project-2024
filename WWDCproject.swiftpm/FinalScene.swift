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
    var textBox = GenericTextBox(title: "Fight time", text: "Now it’s time to confront your fears and come back to the beach! Use the deep breath technique that Leo learned!", nameOfTheSprite: .first, finalAnimation: true)
    var grayBeach = SKSpriteNode(imageNamed: "Beach")
    var coloredBeach = SKSpriteNode(imageNamed: "ColoredBeach")
    var monsterV1 = SKSpriteNode(imageNamed: "Mv1")
    var monsterV2 = SKSpriteNode(imageNamed: "Mv2")
    var monsterV3 = SKSpriteNode(imageNamed: "Mv3")
    var shadow = SKSpriteNode(imageNamed: "Darkness")
    var shadow2 = SKSpriteNode(imageNamed: "Darkness")
    var myImage = SKSpriteNode(imageNamed: "myImage")
    var theEndText = SKSpriteNode(imageNamed: "theEnd")
    let finalDarkness = SKShapeNode(rect: CGRect(x: -Int(SceneConfiguration.shared.width)/2, y: -Int(SceneConfiguration.shared.height)/2, width: Int(SceneConfiguration.shared.width), height: Int(SceneConfiguration.shared.height)))
    
    let badText1 = SKLabelNode(text: "You are a loser")
    let badText2 = SKLabelNode(text: "You won't come back to the beach")
    let badText3 = SKLabelNode(text: "No one loves you")
    let credits = SKLabelNode(text: "Credits: Leonardo Mesquita Alves")
    
    var breathTime1 = BreathMechanic()
    var breathTime2 = BreathMechanic()
    
    var monsterAttackSound: SKAudioNode!
    var fearSound: SKAudioNode!
    
    override func didMove(to view: SKView) {
        setupScene()
        setNodesActions()
    }
    
    func setupScene(){
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        monsterV1.anchorPoint = CGPoint(x: 1, y: 0)
        monsterV2.anchorPoint = CGPoint(x: 1, y: 0)
        monsterV3.anchorPoint = CGPoint(x: 1, y: 0)
        
        coloredBeach.setScale(0.343)
        grayBeach.setScale(0.343)
        monsterV1.setScale(0.3415)
        monsterV2.setScale(0.8)
        monsterV3.setScale(0.75)
        shadow.setScale(0.8)
        myImage.setScale(0.75)
        theEndText.setScale(0.75)
        
        //ZPosition Definition
        coloredBeach.zPosition = 0
        grayBeach.zPosition = 0
        monsterV1.zPosition = 1
        monsterV2.zPosition = 1
        shadow.zPosition = 2
        shadow2.zPosition = 2
        rain.zPosition = 3
        badText1.zPosition = 2.5
        badText2.zPosition = 2.5
        badText3.zPosition = 2.5
        breathTime1.zPosition = 4
        breathTime2.zPosition = 4
        
        monsterV1.position = CGPoint(x: 300, y: -120)
        monsterV2.position = CGPoint(x: 280, y: -120)
        monsterV3.position = CGPoint(x: 200, y: -120)
        myImage.position = CGPoint(x: -20, y: 0)
        
        shadow.alpha = 0.6
        shadow2.alpha = 0
        coloredBeach.alpha = 0
        badText1.alpha = 0
        badText2.alpha = 0
        badText3.alpha = 0
        
        finalDarkness.fillColor = .bgColor
        finalDarkness.strokeColor = .clear
        
        addChild(grayBeach)
        addChild(coloredBeach)
        addChild(textBox)
        addChild(badText1)
        addChild(badText2)
        addChild(badText3)

        if let musicURL = Bundle.main.url(forResource: "monsterAttack", withExtension: "mp3") {
            monsterAttackSound = SKAudioNode(url: musicURL)
            monsterAttackSound.autoplayLooped = false
            addChild(monsterAttackSound)
            
        }
    }
    
    func setNodesActions(){
        textBox.addAction { [self] in
            run(.wait(forDuration: 1)){ [self] in
                rain.alpha = 0
                shadow.alpha = 0
                monsterV1.alpha = 0
                
                addChild(monsterV1)

                addChild(shadow2)
                monsterAttack(x: -200, y: 120, breath: breathTime1, monster: monsterV1, scale: 0.3415)
                
                addChild(rain)
                addChild(shadow)
                
                rain.run(.fadeAlpha(to: 1, duration: 2))
                shadow.run(.fadeAlpha(to: 1, duration: 2))
                monsterV1.run(.fadeAlpha(to: 1, duration: 1))
                
                if let musicURL = Bundle.main.url(forResource: "Medo", withExtension: "m4a") {
                    fearSound = SKAudioNode(url: musicURL)
                    addChild(fearSound)
                    
                    fearSound.run(.changeVolume(to: 0.8, duration: 0))
                    
                }
            }
        }
        
        breathTime1.addAction {
            self.setBreatTime1Action()
        }
        
        breathTime2.addAction { [self] in
            setBreatTime2Action()
            fearSound.run(.changeVolume(to: 0, duration: 0))
        }
    }
    
    //MARK: - First monster
    
    func monsterAttack(x: CGFloat, y: CGFloat, breath: BreathMechanic, monster: SKSpriteNode, scale: CGFloat){
        
        monster.run(.repeatForever(.sequence([
            .scale(to: scale * 1.0161, duration: 2),
            .scale(to: scale * 1.0249, duration: 1),
            .scale(to: scale * 1.0161, duration: 1),
            .scale(to: scale , duration: 0.5),
        ])))
        
        run(.wait(forDuration: 2)){ [self] in
            badText1.zRotation = CGFloat.pi / 16
            badText2.zRotation = -CGFloat.pi / 32
            badText3.zRotation = CGFloat.pi / 16
            
            badText1.fontName = "Futura Bold"
            badText2.fontName = "Futura Bold"
            badText3.fontName = "Futura Bold"
            
            badText1.setScale(0)
            badText2.setScale(0)
            badText3.setScale(0)
            
            badText1.position = CGPoint(x: x, y: y)
            badText2.position = CGPoint(x: x, y: y)
            badText3.position = CGPoint(x: x, y: y)
            
            agressivesMessages(monster: monster, msgXPosition: x, msgYPosition: y, scale: scale, breath: breath)
        }
    }
    
    func agressivesMessages(monster: SKSpriteNode, msgXPosition: CGFloat, msgYPosition: CGFloat, scale: CGFloat, breath: BreathMechanic){
        
        monster.removeAllActions()
        
        let sequence = SKAction.sequence([
            .scaleY(to: scale * 0.937, duration: 0.25),
            .scaleY(to: scale, duration: 0.5),
            .wait(forDuration: 1.25),
        ])
        
        monster.run(.repeatForever(.sequence([sequence, sequence, sequence])))
        
        let sequence2 = SKAction.sequence([
            .wait(forDuration: 0.5),
            .fadeAlpha(to: 0.8, duration: 0.1),
            .wait(forDuration: 1.1),
            .fadeAlpha(to: 0, duration: 0.3),
        ])
        
        let sequence3 = SKAction.sequence([
            .rotate(toAngle: CGFloat.pi / 8, duration: 0.1),
            .rotate(toAngle: -CGFloat.pi / 8, duration: 0.2),
        ])
        
        shadow2.run(.repeatForever(sequence2))
        shadow2.run(.repeatForever(sequence3))
        
        action(label: badText1, waitBefore: 0, waitAfter: 4, x: 300, y: -700)
        action(label: badText2, waitBefore: 2, waitAfter: 2, x: 100, y: -700)
        action(label: badText3, waitBefore: 4, waitAfter: 0, x: 300, y: -700)
        
        func action(label: SKLabelNode, waitBefore: Double, waitAfter: Double, x: CGFloat, y: CGFloat){
            
            let sequence1 = SKAction.sequence([
                SKAction.fadeAlpha(to: 0, duration: 0),
                SKAction.moveTo(x: msgXPosition, duration: 0),
                SKAction.moveTo(y: msgYPosition, duration: 0),
                SKAction.scale(to: 0, duration: 0),
            ])
            
            let sequence2 = SKAction.sequence([
                SKAction.fadeAlpha(to: 0.7, duration: 0),
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
        
        run(SKAction.wait(forDuration: 6)){
            breath.alpha = 0
            self.addChild(breath)
            breath.run(SKAction.fadeAlpha(to: 1, duration: 1.4))
        }
    }

    func setBreatTime1Action(){
        monsterV1.removeFromParent()
        removeActionAndAlpha(node: badText1)
        removeActionAndAlpha(node: badText2)
        removeActionAndAlpha(node: badText3)
        removeActionAndAlpha(node: shadow2)
        
        func removeActionAndAlpha(node: SKNode){
            node.removeAllActions()
            node.alpha = 0
        }
        
        coloredBeach.alpha = 0.15
        shadow.alpha = 0.5
        rain.alpha = 0.6
        
        addChild(monsterV2)
        
        monsterAttack(x: -70, y: 10, breath: breathTime2, monster: monsterV2, scale: 0.8)
        
        rain.changeRainVolume(volume: 0.6)
    }
    
    func setBreatTime2Action(){
        monsterV2.removeFromParent()
        shadow2.removeFromParent()
        removeActionAndAlpha(node: badText1)
        removeActionAndAlpha(node: badText2)
        removeActionAndAlpha(node: badText3)
        removeActionAndAlpha(node: shadow2)
        
        func removeActionAndAlpha(node: SKNode){
            node.removeAllActions()
            node.alpha = 0
        }
        
        coloredBeach.alpha = 0.25
        rain.alpha = 0.2
        
        addChild(monsterV3)
        
        finalAgressiveMessages()
        
        rain.changeRainVolume(volume: 0)
    }
    
    func finalAgressiveMessages(){
        
        action(node: badText1, before: 1, x: 0, y: -140)
        
        action(node: badText2, before: 2, x: 40, y: -130)
        
        action(node: badText3, before: 3, x: 70, y: -135)
        
        func action(node: SKLabelNode, before: CGFloat, x: CGFloat, y: CGFloat){
            
            node.alpha = 1
            node.setScale(0)
            node.position = CGPoint(x: 35, y: -90)
            
            node.run(.sequence([
                .wait(forDuration: before),
                .moveTo(x: x, duration: 1),
            ]))
            
            node.run(.sequence([
                .wait(forDuration: before),
                .moveTo(y: y, duration: 1),
            ]))
            
            node.run(.sequence([
                .wait(forDuration: before),
                .scale(to: 0.2, duration: 1),
            ])){
                node.run(SKAction.fadeAlpha(to: 0, duration: 1))
            }
            
            monsterV3.run(.sequence([
                .wait(forDuration: before),
                .scale(to: 0.7, duration: 0.2),
                .scale(to: 0.78, duration: 0.2),
                .scale(to: 0.75, duration: 0.2),
            ]))
        }
           
        run(.wait(forDuration: 4)){
            self.monsterV3.run( .sequence([
                .move(by: CGVector(dx: 10, dy: 0), duration: 0.2),
                .move(by: CGVector(dx: -10, dy: 0), duration: 0.2),
                .move(by: CGVector(dx: 10, dy: 0), duration: 0.2),
            ])){
                self.monsterV3.run(.repeatForever(.sequence([
                    .move(by: CGVector(dx: -350, dy: 0), duration: 2),
                ])))
                
                self.monsterV3.run(.repeatForever(.sequence([
                    .scale(to: 0.85, duration: 0.5),
                    .scale(to: 0.75, duration: 0.5),
                ])))
                
                self.shadow.run(SKAction.fadeAlpha(to: 0, duration: 4)){ [self] in
                    shadow.removeFromParent()
                    theEndMessage()
                }
                
                self.coloredBeach.run(SKAction.fadeAlpha(to: 1, duration: 4)){
                    self.grayBeach.removeFromParent()
                }
                
                self.rain.run(SKAction.fadeAlpha(to: 0, duration: 4)){
                    self.rain.removeFromParent()
                }
                
            }

        }
        
    }
    
    func theEndMessage(){
        myImage.alpha = 0
        finalDarkness.alpha = 0
        theEndText.alpha = 0
        addChild(finalDarkness)
        addChild(myImage)
        addChild(theEndText)
        addChild(credits)
        
        theEndText.position = CGPoint(x: 0, y: 35)
        credits.position = CGPoint(x: 0, y: -65)
        credits.alpha = 0
        
        myImage.run(.fadeAlpha(to: 1, duration: 2))
        finalDarkness.run(.fadeAlpha(to: 0.96, duration: 2))
        
        run(.wait(forDuration: 5)){ [self] in
            myImage.run(.fadeAlpha(to: 0, duration: 2))
            theEndText.run(.fadeAlpha(to: 1, duration: 2)){
                self.run(.wait(forDuration: 5)){
                    self.nextLevel(MainMenu(), transition: .fade(withDuration: 2))
                }
            }
            credits.run(.fadeAlpha(to: 1, duration: 2))
            finalDarkness.run(.fadeAlpha(to: 1, duration: 2))
        }
    }
    
}
