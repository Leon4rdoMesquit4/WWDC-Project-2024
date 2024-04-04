//
//  Extensions.swift
//  WWDCproject
//
//  Created by Leonardo Mesquita Alves on 09/01/24.
//

import SpriteKit
import UIKit

extension SKColor {
    //Defining the main colors of my game
    static var bgColor = SKColor(named: "Backcolor") ?? .black.withAlphaComponent(0.9)
    static var lightTextColor = SKColor.white
    static var darkTextColor = SKColor(named: "TextColor") ?? .black.withAlphaComponent(0.9)
    static var magicPurple = SKColor(named: "MagicPurple") ?? .purple
}

extension SKScene{
    
    //I'm using this extension to help me passing to the next level with the correct atributes
    func nextLevel(_ a: SKScene, transition: SKTransition){
        a.scaleMode = .aspectFill
        a.size = SceneConfiguration.shared.size
        self.view?.presentScene(a, transition: transition)
    }
    
}
