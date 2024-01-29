//
//  BreathScene.swift
//  WWDCproject
//
//  Created by Leonardo Mesquita Alves on 14/01/24.
//

import SpriteKit
import SwiftUI

class BreathScene: SKScene {
    var textbox = GenericTextBox(title: "Meditation time", text: "A way to control your anxious and get more relax is to breath. When you do that you control your heart rate and can make the monster dissapear for a while.", nameOfTheSprite: .first)
    
    var finalTextbox = GenericTextBox(title: "Congrats!", text: "John learned how to control his breath and heart rate. It will help him in his fight against the monster", nameOfTheSprite: .first)
    
    var holdTextLabel = SKLabelNode(text: "PRESS AND HOLD")
    var bpmTextLabel = SKLabelNode(text: "108 bpm")
//    var messageTextLabel = SKLabelNode(text: "Control John’s breath and your heart rate")
    
    var mainCircle = SKSpriteNode(imageNamed: "Circle3")
    var middleCircle = SKSpriteNode(imageNamed: "Circle2")
    var centerCircle = SKSpriteNode(imageNamed: "Circle1")
    var coloredCircle = SKShapeNode(circleOfRadius: 1.3725)
    // The best size 137.25
    
    var isOnboardingEnded: Bool = false
    var isBreathing: Bool = false
    var breathCount: Int = 0
    var touchBeg: Bool = true
    
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
        
        holdTextLabel.position = CGPoint(x: 0, y: +240)
        holdTextLabel.fontName = "Futura Bold"
        holdTextLabel.fontSize = 39
        holdTextLabel.alpha = 0
        
        bpmTextLabel.position = CGPoint(x: 0, y: -260)
        bpmTextLabel.fontName = "Futura Bold"
        bpmTextLabel.fontSize = 30
        bpmTextLabel.alpha = 0
        
        coloredCircle.fillColor = .magicPurple
        coloredCircle.strokeColor = .clear
        coloredCircle.alpha = 0
        
//        messageTextLabel.position = CGPoint(x: 0, y: -230)
//        messageTextLabel.fontName = "Futura"
//        messageTextLabel.fontSize = 25
        
        textbox.addAction {
            self.firstCircleAnimation(circle: self.centerCircle)
            self.firstCircleAnimation(circle: self.mainCircle)
            self.secondCircleAnimation(circle: self.middleCircle)
            self.fadeFirstSceneAlpha()
        }
        
        finalTextbox.addAction {
            self.nextLevel(FinalScene(), transition: .crossFade(withDuration: 1))
        }
        
        finalTextbox.backgroundT.alpha = 0
        finalTextbox.setScale(0)
        finalTextbox.position = CGPoint(x: 300, y: -300)
        
        addChild(mainCircle)
        addChild(middleCircle)
        addChild(centerCircle)
        addChild(holdTextLabel)
        addChild(bpmTextLabel)
        addChild(coloredCircle)
//        addChild(messageTextLabel)
        addChild(textbox)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isOnboardingEnded{
            if !isBreathing{
                coloredCircle.run(SKAction.scale(to: 100, duration: 4)){
                    self.holdTextLabel.text = "WAIT"
                    self.coloredCircle.run(SKAction.wait(forDuration: 4)){
                        self.isBreathing = true
                        self.holdTextLabel.text = "SOLTE"
                    }
                }
                removeCirclesAnimation()
            }
        }
    }
    

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touchBeg{
            setUpTouchEnded()
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touchBeg{
            setUpTouchEnded()
        }
    }
    
    func setUpTouchEnded(){
        if isOnboardingEnded {
            if isBreathing && breathCount == 1 {
                touchBeg = false
                coloredCircle.run(SKAction.scale(to: 1, duration: 4)){ [self] in
                    coloredCircle.run(SKAction.scale(to: 2000, duration: 0.2)){ [self] in
                        addChild(finalTextbox)
                        
                        finalTextbox.run(SKAction.scale(to: 1, duration: 0.2))
                        finalTextbox.run(SKAction.move(to: CGPoint(x: 0, y: 0), duration: 0.2))
                    }
                }
            } else if isBreathing && breathCount == 0 {
                touchBeg = false
                coloredCircle.run(SKAction.scale(to: 1, duration: 4)){ [self] in
                    holdTextLabel.text = "PRESS AND HOLD"
                    infiniteCircleAnimation()
                    isBreathing = false
                    touchBeg = true
                    breathCount = 1
                }
            } else if !isBreathing {
                touchCancelledBefore()
            }
        }
    }
    
    func touchCancelledBefore(){
        coloredCircle.removeAllActions()
        coloredCircle.run(SKAction.scale(to: 1, duration: 0.1))
        infiniteCircleAnimation()
        
        let errorSprite = SKSpriteNode(imageNamed: "x")
        errorSprite.setScale(0)
        errorSprite.position = CGPoint(x: 190, y: 100)
        errorSprite.zRotation = CGFloat.pi / CGFloat((Int.random(in: 0...3)))
        
        addChild(errorSprite)
        
        let sequence = SKAction.sequence([
            SKAction.move(to: CGPoint(x: 190, y: 160), duration: 0.2),
            SKAction.wait(forDuration: 0.3),
            SKAction.move(to: CGPoint(x: 190, y: 80), duration: 0.1)
        ])
        
        let sequence2 = SKAction.sequence([
            SKAction.rotate(byAngle: CGFloat.pi / 8, duration: 0.05),
            SKAction.rotate(byAngle: CGFloat.pi / -8, duration: 0.05),
            SKAction.rotate(byAngle: CGFloat.pi / 8, duration: 0.05),
            SKAction.rotate(byAngle: CGFloat.pi / -8, duration: 0.05),
        ])
        
        let sequence3 = SKAction.sequence([
            SKAction.scale(to: 0.75, duration: 0.1),
            SKAction.wait(forDuration: 0.4),
            SKAction.scale(to: 0, duration: 0.1),
        ])
        
        errorSprite.run(sequence)
        errorSprite.run(sequence2)
        errorSprite.run(sequence3){
            errorSprite.removeFromParent()
        }
        
        self.holdTextLabel.text = "PRESS AND HOLD"
    }
    
    func infiniteCircleAnimation(){
        centerCircle.run(SKAction.repeatForever(
                SKAction.sequence([
                    SKAction.wait(forDuration: 1.1),
                    SKAction.scale(to: 0.8, duration: 0.5),
                    SKAction.scale(to: 0.75, duration: 0.5),
                    SKAction.wait(forDuration: 0.4),
                ])
            )
        )
        
        middleCircle.run(SKAction.repeatForever(
                SKAction.sequence([
                    SKAction.wait(forDuration: 1.3),
                    SKAction.scale(to: 0.8, duration: 0.5),
                    SKAction.scale(to: 0.75, duration: 0.5),
                    SKAction.wait(forDuration: 0.2),
                ])
            )
        )
        
        mainCircle.run(SKAction.repeatForever(
                SKAction.sequence([
                    SKAction.wait(forDuration: 1.5),
                    SKAction.scale(to: 0.8, duration: 0.5),
                    SKAction.scale(to: 0.75, duration: 0.5),
                ])
            )
        )

    }
    
    func removeCirclesAnimation(){
        mainCircle.removeAllActions()
        middleCircle.removeAllActions()
        centerCircle.removeAllActions()
        
        mainCircle.run(SKAction.scale(to: 0.75, duration: 0.2))
        middleCircle.run(SKAction.scale(to: 0.75, duration: 0.2))
        centerCircle.run(SKAction.scale(to: 0.75, duration: 0.2))
    }
    
    func fadeFirstSceneAlpha(){
        run(SKAction.wait(forDuration: 1.4)){
            self.bpmTextLabel.run(SKAction.fadeAlpha(to: 0.2, duration: 0.2))
            self.holdTextLabel.run(SKAction.fadeAlpha(to: 0.9, duration: 0.2))
            self.coloredCircle.run(SKAction.fadeAlpha(to: 1, duration: 0.2))
        }
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
        ){
            self.isOnboardingEnded = true
            self.infiniteCircleAnimation()
        }
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
