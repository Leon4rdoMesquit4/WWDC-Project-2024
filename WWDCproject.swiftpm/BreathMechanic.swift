//
//  BreathMechanic.swift
//  WWDCproject
//
//  Created by Leonardo Mesquita Alves on 27/01/24.
//

import SpriteKit
import SwiftUI

class BreathMechanic: SKNode {
    var mainCircle = SKSpriteNode(imageNamed: "Circle3")
    var middleCircle = SKSpriteNode(imageNamed: "Circle2")
    var centerCircle = SKSpriteNode(imageNamed: "Circle1")
    var coloredCircle = SKShapeNode(circleOfRadius: 1.3725)
    
    var holdTextLabel = SKLabelNode(text: "PRESS AND HOLD")
    var bpmTextLabel = SKLabelNode(text: "")
    
    var isOnboardingEnded: Bool = false
    var isBreathing: Bool = false
    var touchBeg: Bool = true
    
    var callback: (() -> Void)?
    
    let darkness = SKShapeNode(rect: CGRect(x: -Int(SceneConfiguration.shared.width)/2, y: -Int(SceneConfiguration.shared.height)/2, width: Int(SceneConfiguration.shared.width), height: Int(SceneConfiguration.shared.height)))
    
    
    override init() {
        
        super.init()
        
        darkness.fillColor = .bgColor
        darkness.strokeColor = .clear
        darkness.alpha = 0.7
        
        addChild(darkness)
        
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
        
        addChild(mainCircle)
        addChild(middleCircle)
        addChild(centerCircle)
        addChild(holdTextLabel)
        addChild(bpmTextLabel)
        addChild(coloredCircle)
        
        self.firstCircleAnimation(circle: self.centerCircle)
        self.firstCircleAnimation(circle: self.mainCircle)
        self.secondCircleAnimation(circle: self.middleCircle)
        self.fadeFirstSceneAlpha()
        darkness.run(SKAction.fadeAlpha(to: 0.8, duration: 1.4))
        
        isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    func executeCallbackAction(callback: () -> Void){
        mainCircle.removeFromParent()
        middleCircle.removeFromParent()
        centerCircle.removeFromParent()
        holdTextLabel.removeFromParent()
        bpmTextLabel.removeFromParent()
        darkness.removeFromParent()
        
        coloredCircle.run(SKAction.fadeAlpha(to: 0, duration: 3))
        callback()
    }
    
    func setUpTouchEnded(){
        if isOnboardingEnded {
            if isBreathing {
                breathSound(resourceName: "out")
                touchBeg = false
                coloredCircle.run(SKAction.scale(to: 1, duration: 3)){ [self] in
                    coloredCircle.run(SKAction.scale(to: 2000, duration: 0.4)){
                        self.executeCallbackAction {
                            self.callback!()
                        }
                    }
                }
            }
            else if !isBreathing {
                touchCancelledBefore()
            }
        }
    }
    
    func addAction(callback: @escaping (() -> Void)){
        self.callback = callback
    }
    
    func touchCancelledBefore(){
        cancellBreathSound()
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
                    SKAction.scale(to: 0.83, duration: 0.5),
                    SKAction.scale(to: 0.75, duration: 0.5),
                    SKAction.wait(forDuration: 0.4),
                ])
            )
        )
        
        middleCircle.run(SKAction.repeatForever(
                SKAction.sequence([
                    SKAction.wait(forDuration: 1.3),
                    SKAction.scale(to: 0.83, duration: 0.5),
                    SKAction.scale(to: 0.75, duration: 0.5),
                    SKAction.wait(forDuration: 0.2),
                ])
            )
        )
        
        mainCircle.run(SKAction.repeatForever(
                SKAction.sequence([
                    SKAction.wait(forDuration: 1.5),
                    SKAction.scale(to: 0.83, duration: 0.5),
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
        bpmTextLabel.removeAllChildren()
    }
    
}
