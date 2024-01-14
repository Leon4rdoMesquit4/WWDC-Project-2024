//
//  FirstScene.swift
//  WWDCproject
//
//  Created by Leonardo Mesquita Alves on 11/01/24.
//

import SpriteKit
import SwiftUI


struct DisplayTest: View {
    
    var storyScene: SKScene {
        let scene = FirstScene()
        scene.size = SceneConfigs.shared.size
        scene.scaleMode = .aspectFill
        return scene
    }
    
    var body: some View {
        SpriteView(scene: storyScene)
            .ignoresSafeArea()
    }
}

#Preview {
    DisplayTest()
}

class FirstScene: SKScene {
    
    var textBox: GenericTextBox = GenericTextBox(title: "School time", text: "The monster is trying to attack John’s school. Help John to discover what is making the monster come back from the shadows!")
    
    let coloredSchool: SKSpriteNode = SKSpriteNode(imageNamed: "ColoredSchool")
    
    let jumpscare: SKSpriteNode = SKSpriteNode(imageNamed: "Story4")
    
    let darkness2: SKSpriteNode = SKSpriteNode(color: .black, size: SceneConfigs.shared.size)
    
    let darkness1: SKSpriteNode = SKSpriteNode(imageNamed: "Darkness1")
    
    var saturation = SKEffectNode()
    
    var ballShineShap: SKSpriteNode = SKSpriteNode(imageNamed: "Ball")
    
    var posterShineShap: SKSpriteNode = SKSpriteNode(imageNamed: "Poster")
    
    var monsterSprite: SKSpriteNode = SKSpriteNode(imageNamed: "Monster")
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.bgColor
        
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        darkness2.alpha = 0
        jumpscare.setScale(0.7)
        jumpscare.position = CGPoint(x: 0, y: -160)
        jumpscare.alpha = 0
        
        ballShineShap.position = CGPoint(x: -404, y: -172)
        ballShineShap.setScale(0.3415)
        ballShineShap.alpha = 0
        
        posterShineShap.position = CGPoint(x: -9, y: 40)
        posterShineShap.setScale(0.3415)
        
        coloredSchool.setScale(0.3415)
        darkness1.position = CGPoint(x: 0, y: 180)
        darkness1.setScale(0.75)
        darkness1.alpha = 0
        
        saturation.addChild(coloredSchool)
        saturation.filter = CIFilter(name: "CIColorControls")
        
        addChild(saturation)
        addChild(darkness2)
        addChild(darkness1)
        addChild(jumpscare)
        addChild(ballShineShap)
        addChild(posterShineShap)
        addChild(textBox)
        
        textBox.addAction {
            self.jumpscareAction()
            self.shineAction()
        }
    }
    
    func shineAction(){
        let actionForShine = SKAction.sequence([
            SKAction.fadeAlpha(to: 0.4, duration: 0.3),
            SKAction.fadeAlpha(to: 0, duration: 0.7),
        ])
        
        let actionForScale = SKAction.sequence([
            SKAction.scale(to: 0.35, duration: 0.5),
            SKAction.scale(to: 0.3, duration: 0.5),
        ])
        
        ballShineShap.run(SKAction.repeatForever(actionForScale))
        ballShineShap.run(SKAction.repeatForever(actionForShine))
        posterShineShap.run(SKAction.repeatForever(actionForScale))
        posterShineShap.run(SKAction.repeatForever(actionForShine))
    }
    
    func jumpscareAction(){
        
        let actionsForSaturation = SKAction.sequence([
            SKAction.run {
                self.saturation.filter?.setValue(0.3, forKey: kCIInputSaturationKey)
            },
            SKAction.wait(forDuration: 1),
            SKAction.run {
                self.saturation.filter?.setValue(0.1, forKey: kCIInputSaturationKey)
            },
            SKAction.wait(forDuration: 3),
            SKAction.run {
                self.saturation.filter?.setValue(0, forKey: kCIInputSaturationKey)
                
            },
        ])
        
        let actions = SKAction.sequence([
            SKAction.wait(forDuration: 1),
            SKAction.fadeAlpha(to: 0.8, duration: 0.05),
            SKAction.wait(forDuration: 0.4),
            SKAction.fadeAlpha(to: 0, duration: 0.05),
            SKAction.fadeAlpha(to: 0.8, duration: 0.05),
            SKAction.wait(forDuration: 0.05),
            SKAction.fadeAlpha(to: 0, duration: 0.05),
            SKAction.fadeAlpha(to: 0.8, duration: 0.025),
            SKAction.wait(forDuration: 0.4),
            SKAction.fadeAlpha(to: 0, duration: 0.025),
            SKAction.fadeAlpha(to: 0.8, duration: 0.05),
            SKAction.wait(forDuration: 0.8),
            SKAction.fadeAlpha(to: 0, duration: 0.025),
            SKAction.fadeAlpha(to: 0.8, duration: 0.05),
            SKAction.wait(forDuration: 0.4),
            SKAction.fadeAlpha(to: 0, duration: 0.05),
            SKAction.fadeAlpha(to: 0.8, duration: 0.05),
            SKAction.wait(forDuration: 0.05),
            SKAction.fadeAlpha(to: 0, duration: 0.05),
            SKAction.wait(forDuration: 1.0),
            SKAction.fadeAlpha(to: 0.8, duration: 0.05),
            SKAction.wait(forDuration: 1.0),
        ])
        
        self.run(actionsForSaturation)
        
        self.darkness2.run(actions){
            self.darkness2.alpha = 0.5
            self.darkness1.alpha = 1
        }
        self.jumpscare.run(actions){
            self.jumpscare.alpha = 0
        }
    }
    
}


