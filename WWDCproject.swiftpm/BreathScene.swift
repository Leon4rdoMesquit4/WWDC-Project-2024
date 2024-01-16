//
//  BreathScene.swift
//  WWDCproject
//
//  Created by Leonardo Mesquita Alves on 14/01/24.
//

import SpriteKit
import SwiftUI

struct DisplayTest: View {
    
    var storyScene: SKScene {
        let scene = BreathScene()
        scene.size = SceneConfiguration.shared.size
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

class BreathScene: SKScene {
    var textbox = GenericTextBox(title: "Meditation time", text: "A way to control your anxious and get more relax is to breath. When you do that you control your heart rate and can make the monster dissapear for a while.", nameOfTheSprite: .first)
    
    var holdTextLabel = SKLabelNode(text: "Press and hold")
    var bpmTextLabel = SKLabelNode(text: "108 bpm")
    var messageTextLabel = SKLabelNode(text: "Press and hold")
    
    var mainCircle = SKSpriteNode(imageNamed: "Circle3")
    var middleCircle = SKSpriteNode(imageNamed: "Circle2")
    var centerCircle = SKSpriteNode(imageNamed: "Circle1")
    
    override func didMove(to view: SKView) {
        backgroundColor = .bgColor
        
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        mainCircle.alpha = 0
        mainCircle.setScale(1.5)
        mainCircle.zRotation = CGFloat.pi / 8
        
        middleCircle.alpha = 0
        middleCircle.setScale(1.5)
        middleCircle.zRotation = CGFloat.pi / 8
        
        centerCircle.alpha = 0
        centerCircle.setScale(1.5)
        centerCircle.zRotation = CGFloat.pi / 8
        
        textbox.addAction {
            self.firstCircleAnimation(circle: self.centerCircle)
            self.firstCircleAnimation(circle: self.mainCircle)
            self.secondCircleAnimation(circle: self.middleCircle)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                self.infiniteCircleAnimation()
            }
        }
        
        addChild(mainCircle)
        addChild(middleCircle)
        addChild(centerCircle)
        //addChild()
        addChild(textbox)
    }
    
    func infiniteCircleAnimation(){
        centerCircle.run(SKAction.repeatForever(
                SKAction.sequence([
                    SKAction.scale(to: 0.8, duration: 0.5),
                    SKAction.scale(to: 0.75, duration: 0.5),
                    SKAction.wait(forDuration: 1.5)
                ])
            )
        )
        
        middleCircle.run(SKAction.repeatForever(
                SKAction.sequence([
                    SKAction.wait(forDuration: 0.2),
                    SKAction.scale(to: 0.8, duration: 0.5),
                    SKAction.scale(to: 0.75, duration: 0.5),
                    SKAction.wait(forDuration: 1.3),
                ])
            )
        )
        
        mainCircle.run(SKAction.repeatForever(
                SKAction.sequence([
                    SKAction.wait(forDuration: 0.4),
                    SKAction.scale(to: 0.8, duration: 0.5),
                    SKAction.scale(to: 0.75, duration: 0.5),
                    SKAction.wait(forDuration: 1.1),
                ])
            )
        )
        
    }
    
    func firstCircleAnimation(circle: SKSpriteNode){
        circle.run(
            SKAction.rotate(toAngle: CGFloat.pi / 2, duration: 1.6)
        )
        circle.run(
            SKAction.fadeAlpha(to: 1, duration: 1.6)
        )
        circle.run(
            SKAction.scale(to: 0.75, duration: 1.6)
        )
    }
    
    func secondCircleAnimation(circle: SKSpriteNode){
        circle.run(
            SKAction.rotate(toAngle: -CGFloat.pi / 2, duration: 1.6)
        )
        circle.run(
            SKAction.fadeAlpha(to: 1, duration: 1.6)
        )
        circle.run(
            SKAction.scale(to: 0.75, duration: 1.6)
        )
    }
    
    
}
