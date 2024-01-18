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

