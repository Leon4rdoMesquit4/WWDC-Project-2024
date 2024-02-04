//
//  RainAnimation.swift
//  WWDCproject
//
//  Created by Leonardo Mesquita Alves on 18/01/24.
//

import SpriteKit

class RainAnimation: SKNode {
    var rainSprite1: SKSpriteNode = SKSpriteNode(imageNamed: "Rain")
    var rainSprite2: SKSpriteNode = SKSpriteNode(imageNamed: "Rain")
    
    var rainAudio: SKAudioNode!
    
    override init() {
        super.init()
        
        rainSprite1.setScale(0.3415)
        rainSprite1.position = CGPoint(x: 0, y: rainSprite1.size.height - 25)
        //2514.89479
        
        rainSprite2.setScale(0.3415)
        rainSprite2.xScale = -0.3415
                
        addChild(rainSprite1)
        addChild(rainSprite2)
        fallingRainAnimation()
    }
    
    func fallingRainAnimation(){
        rainSprite1.run(SKAction.repeatForever(SKAction.move(by: CGVector(dx: 0, dy: -750), duration: 1)))
        rainSprite2.run(SKAction.repeatForever(SKAction.move(by: CGVector(dx: 0, dy: -750), duration: 1)))
        
        let sequence1 = SKAction.repeatForever(SKAction.sequence([
            SKAction.wait(forDuration: 1.333333),
            SKAction.run { [self] in
                rainSprite2.position = CGPoint(x: 0, y: rainSprite1.size.height - 25)
                rainSprite2.xScale = rainSprite2.xScale * -1
            },
            SKAction.wait(forDuration: 1.333333),
        ]))
        
        let sequence2 = SKAction.repeatForever(SKAction.sequence([
            SKAction.run { [self] in
                rainSprite1.position = CGPoint(x: 0, y: rainSprite1.size.height - 25)
                rainSprite1.xScale = rainSprite1.xScale * -1
            },
            SKAction.wait(forDuration: 2.666666),
        ]))
        
        if let musicURL = Bundle.main.url(forResource: "Chuvaa", withExtension: "mp3") {
            rainAudio = SKAudioNode(url: musicURL)
            
            addChild(rainAudio)
        }
        
        run(SKAction.repeatForever(sequence1))
        run(SKAction.repeatForever(sequence2))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeRainVolume(volume: Float){
        rainAudio.run(.changeVolume(to: volume, duration: 8))
    }
    
}
