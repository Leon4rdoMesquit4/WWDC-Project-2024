//
//  FirstScene.swift
//  WWDCproject
//
//  Created by Leonardo Mesquita Alves on 11/01/24.
//

import SpriteKit
import SwiftUI

class FirstScene: SKScene {
    
    var textBox: GenericTextBox = GenericTextBox(title: "School time", text: "The monster is trying to attack Leo's school. Help Leo discover what is causing the monster to emerge from the shadows!", nameOfTheSprite: .first, finalAnimation: true)
    var triggerTextBox: GenericTextBox = GenericTextBox(title: "Triggers", text: "The monster gets stronger when Leo sees beach elements.\n\nIt reminds him of bad memories and makes Leo anxious and sad. ", nameOfTheSprite: .trigger, finalAnimation: false)
    
    let coloredSchool: SKSpriteNode = SKSpriteNode(imageNamed: "ColoredSchool")
    let jumpscare: SKSpriteNode = SKSpriteNode(imageNamed: "Story4")
    let darkness2: SKSpriteNode = SKSpriteNode(color: .black, size: SceneConfiguration.shared.size)
    let darkness1: SKSpriteNode = SKSpriteNode(imageNamed: "Darkness1")
    var ballShineShap: SKSpriteNode = SKSpriteNode(imageNamed: "Ball")
    var posterShineShap: SKSpriteNode = SKSpriteNode(imageNamed: "Poster")
    var monsterSprite: SKSpriteNode = SKSpriteNode(imageNamed: "Monster")
    
    var saturation = SKEffectNode()
    
    var isSceneEnded: Bool = true
    
    var jumpscareMusic: SKAudioNode!
    var posJumpscareMusic: SKAudioNode!
    var posJumpscareMusic2: SKAudioNode!
    
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
        posterShineShap.alpha = 0
        
        coloredSchool.setScale(0.3415)
        darkness1.position = CGPoint(x: 0, y: 210)
        darkness1.setScale(0.75)
        darkness1.alpha = 0
        
        saturation.addChild(coloredSchool)
        saturation.filter = CIFilter(name: "CIColorControls")
        
        monsterSprite.setScale(0.3415)
        monsterSprite.position = CGPoint(x: -385, y: 155)
        monsterSprite.anchorPoint = CGPoint(x: 0.5, y: 1)
        
        addChild(saturation)
        addChild(darkness2)
        addChild(darkness1)
        addChild(jumpscare)
        addChild(ballShineShap)
        addChild(posterShineShap)
        addChild(textBox)
        
        
        textBox.addAction {
            self.jumpscareAction()
        }
        
        triggerTextBox.addAction {
            self.nextLevel(BreathScene(), transition: .fade(withDuration: 0.5))
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !isSceneEnded{
            for touch in touches {
                let location = touch.location(in: self)
                if posterShineShap.contains(location) || ballShineShap.contains(location){
                    
                    isSceneEnded = true
                    
                    self.addChild(triggerTextBox)
                    triggerTextBox.alpha = 0
                    
                    triggerTextBox.run(SKAction.fadeAlpha(to: 1, duration: 1))
                    
                    posJumpscareMusic.run(.changeVolume(to: 0.05, duration: 3))
                    posJumpscareMusic2.run(.changeVolume(to: 0.05, duration: 3))
                }
            }
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
        
        let monsterAction = SKAction.sequence([
            SKAction.scaleY(to: 0.3415, duration: 0.2),
            SKAction.scaleY(to: 0.3, duration: 1),
            SKAction.scaleY(to: 0.27, duration: 1.3),
            SKAction.scaleY(to: 0.3, duration: 0.1),
        ])
        
        ballShineShap.run(SKAction.repeatForever(actionForScale))
        ballShineShap.run(SKAction.repeatForever(actionForShine))
        posterShineShap.run(SKAction.repeatForever(actionForScale))
        posterShineShap.run(SKAction.repeatForever(actionForShine))
        monsterSprite.run(SKAction.repeatForever(monsterAction))
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
        
        if let musicURL = Bundle.main.url(forResource: "Medo", withExtension: "m4a") {
            posJumpscareMusic = SKAudioNode(url: musicURL)
            posJumpscareMusic2 = SKAudioNode(url: musicURL)
        }
        
        if let musicURL = Bundle.main.url(forResource: "ah1", withExtension: "mp3") {
            run(.wait(forDuration: 1)){ [self] in
                jumpscareMusic = SKAudioNode(url: musicURL)
                jumpscareMusic.autoplayLooped = false
                addChild(jumpscareMusic)
                jumpscareMusic.run(.play())
            }
        }
        
        self.darkness2.run(actions){ [self] in
            addChild(monsterSprite)
            isSceneEnded = false
            shineAction()
            darkness2.alpha = 0.5
            darkness1.alpha = 1
        }
        self.jumpscare.run(actions){ [self] in
            jumpscare.alpha = 0
            addChild(posJumpscareMusic)
            
            posJumpscareMusic.run(.changeVolume(to: 0.5, duration: 0))
            
            run(.wait(forDuration: 1)){
                self.addChild(self.posJumpscareMusic2)
                self.posJumpscareMusic2.run(.changeVolume(to: 0.5, duration: 0))
            }
        }
    }
    
}
