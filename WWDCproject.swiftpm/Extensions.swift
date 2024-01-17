//
//  Extensions.swift
//  WWDCproject
//
//  Created by Leonardo Mesquita Alves on 09/01/24.
//

import SpriteKit
import UIKit

extension SKColor {
    static var bgColor = SKColor(named: "Backcolor") ?? .black.withAlphaComponent(0.9)
    static var lightTextColor = SKColor.white
    static var darkTextColor = SKColor(named: "TextColor") ?? .black.withAlphaComponent(0.9)
    static var magicPurple = SKColor(named: "MagicPurple") ?? .purple
}

extension SKScene{
    
    func nextLevel(_ a: String, direction: SKTransitionDirection){
        if let scene = SKScene(fileNamed: a){
            scene.scaleMode = .aspectFill
            scene.size = SceneConfiguration.shared.size
            self.view?.presentScene(scene, transition: SKTransition.push(with: direction, duration: 3))
        }
    }
    
    func nextLevel(_ a: String, transition: SKTransition){
        if let scene = SKScene(fileNamed: a){
            scene.scaleMode = .aspectFill
            scene.size = SceneConfiguration.shared.size
            self.view?.presentScene(scene, transition: transition)
        }
    }
    
    func nextLevel(_ a: SKScene, transition: SKTransition){
        a.scaleMode = .aspectFill
        a.size = SceneConfiguration.shared.size
        self.view?.presentScene(a, transition: transition)
    }
    
}
