//
//  BreathScene.swift
//  WWDCproject
//
//  Created by Leonardo Mesquita Alves on 14/01/24.
//

import SpriteKit
import SwiftUI

class BreathScene: SKScene {
    var textbox = GenericTextBox(title: "Meditation time", text: "A way to control your anxiety and become more relaxed is to breathe. When you do that, you can control your heart rate and make the monster disappear for a while.", nameOfTheSprite: .first, finalAnimation: true)
    
    var finalTextbox = GenericTextBox(title: "Congrats!", text: "Leo learned how to control his breath and heart rate. It will help him in his fight against the monster", nameOfTheSprite: .first, finalAnimation: false)
    
    var holdTextLabel = SKLabelNode(text: "PRESS AND HOLD")
    var bpmTextLabel = SKLabelNode(text: "")
    
    var mainCircle = SKSpriteNode(imageNamed: "Circle3")
    var middleCircle = SKSpriteNode(imageNamed: "Circle2")
    var centerCircle = SKSpriteNode(imageNamed: "Circle1")
    var coloredCircle = SKShapeNode(circleOfRadius: 1.3725)
    // The best size 137.25
    
    var isOnboardingEnded: Bool = false
    var isBreathing: Bool = false
    var breathCount: Int = 0
    var touchBeg: Bool = true
    var quickBreath: SKAudioNode!
    var quickBreath2: SKAudioNode!
    
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
        
        textbox.addAction { [self] in
            firstCircleAnimation(circle: centerCircle)
            firstCircleAnimation(circle: mainCircle)
            secondCircleAnimation(circle: middleCircle)
            fadeFirstSceneAlpha()
            quickBreath.run(.changeVolume(to: 0.8, duration: 0))
        }
        
        finalTextbox.addAction {
            self.nextLevel(FinalScene(), transition: .fade(withDuration: 1))
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
        
        if let musicURL = Bundle.main.url(forResource: "breath", withExtension: "m4a") {
            quickBreath = SKAudioNode(url: musicURL)
            addChild(quickBreath)
            
            quickBreath.run(.changeVolume(to: 0.1, duration: 0))
        }
        
        if let musicURL = Bundle.main.url(forResource: "quickBreath2", withExtension: "m4a") {
            quickBreath2 = SKAudioNode(url: musicURL)
            addChild(quickBreath2)
            quickBreath2.run(.changeVolume(to: 0, duration: 0))
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isOnboardingEnded{
            if !isBreathing{
                breathSound(resourceName: "in")
                coloredCircle.run(SKAction.scale(to: 100, duration: 3)){
                    self.holdTextLabel.text = "WAIT"
                    self.coloredCircle.run(SKAction.wait(forDuration: 3)){
                        self.isBreathing = true
                        self.holdTextLabel.text = "RELEASE"
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
                breathSound(resourceName: "out")
                touchBeg = false
                coloredCircle.run(SKAction.scale(to: 1, duration: 3)){ [self] in
                    coloredCircle.run(SKAction.scale(to: 2000, duration: 0.2)){ [self] in
                        addChild(finalTextbox)
                        
                        finalTextbox.run(SKAction.scale(to: 1, duration: 0.2))
                        finalTextbox.run(SKAction.move(to: CGPoint(x: 0, y: 0), duration: 0.2))
                    }
                }
            } else if isBreathing && breathCount == 0 {
                breathSound(resourceName: "out")
                touchBeg = false
                coloredCircle.run(SKAction.scale(to: 1, duration: 3)){ [self] in
                    holdTextLabel.text = "PRESS AND HOLD"
                    infiniteCircleAnimation()
                    isBreathing = false
                    touchBeg = true
                    breathCount = 1
                    quickBreath2.run(.changeVolume(to: 0.5, duration: 0))
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
        
        if breathCount == 0 {
            cancellBreathSound()
        } else if breathCount == 1 {
            cancellBreathSound2()
        }

        if let musicURL = Bundle.main.url(forResource: "errorSound", withExtension: "mp3") {
            var errorSound: SKAudioNode!
            errorSound = SKAudioNode(url: musicURL)
            errorSound.autoplayLooped = false
            addChild(errorSound)
            errorSound.run(.play())
        }
        
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
    
    func breathSound(resourceName: String){
        quickBreath.run(.changeVolume(to: 0, duration: 0))
        quickBreath2.run(.changeVolume(to: 0, duration: 0))
            if let musicURL = Bundle.main.url(forResource: resourceName, withExtension: "m4a") {
                let breath = SKAudioNode(url: musicURL)
                breath.name = "breath"
                breath.autoplayLooped = false
                self.bpmTextLabel.addChild(breath)
                run(.wait(forDuration: 0.6)){
                    breath.run(.play()){
                        self.run(.wait(forDuration: 3)){
                            breath.removeFromParent()
                        }
                    }
                }
            }
    }
    
    func cancellBreathSound(){
        
        quickBreath.run(.changeVolume(to: 0.5, duration: 0))
        
        bpmTextLabel.removeAllChildren()
    }
    
    func cancellBreathSound2(){
        
        quickBreath2.run(.changeVolume(to: 0.5, duration: 0))
        
        bpmTextLabel.removeAllChildren()
    }
    
}
