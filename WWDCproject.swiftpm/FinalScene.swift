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
    
    override func didMove(to view: SKView) {
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        addChild(rain)
    }
}

class RainAnimation: SKNode {
    var rainSprite1: SKSpriteNode = SKSpriteNode(imageNamed: "Rain")
    var rainSprite2: SKSpriteNode = SKSpriteNode(imageNamed: "Rain")
    
    override init() {
        super.init()
        
        rainSprite1.setScale(0.3415)
        rainSprite1.position = CGPoint(x: 0, y: rainSprite1.size.height - 25)
        //2514.89479
        
        rainSprite2.setScale(0.3415)
        rainSprite2.xScale = -0.3415
        
        print(rainSprite1.size.height)
        
        addChild(rainSprite1)
        addChild(rainSprite2)
        fallingRainAnimation()
    }
    
    func fallingRainAnimation(){
        rainSprite1.run(SKAction.repeatForever(SKAction.move(by: CGVector(dx: 0, dy: -500), duration: 1)))
        rainSprite2.run(SKAction.repeatForever(SKAction.move(by: CGVector(dx: 0, dy: -500), duration: 1)))
        
        let sequence1 = SKAction.repeatForever(SKAction.sequence([
            SKAction.wait(forDuration: 2),
            SKAction.run { [self] in
                rainSprite2.position = CGPoint(x: 0, y: rainSprite1.size.height - 25)
                rainSprite2.xScale = rainSprite2.xScale * -1
            },
            SKAction.wait(forDuration: 2),
        ]))
        
        let sequence2 = SKAction.repeatForever(SKAction.sequence([
            SKAction.run { [self] in
                rainSprite1.position = CGPoint(x: 0, y: rainSprite1.size.height - 25)
                rainSprite1.xScale = rainSprite1.xScale * -1
            },
            SKAction.wait(forDuration: 4),
        ]))
        
        run(SKAction.repeatForever(sequence1))
        run(SKAction.repeatForever(sequence2))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
