//
//  StoryScene.swift
//  WWDCproject
//
//  Created by Leonardo Mesquita Alves on 07/01/24.
//

import SpriteKit
import SwiftUI

class StoryScene: SKScene {
    
    let storyData = [
        ["John always loved to go to the beach", "Since he was a kid"],
        ["But someday evething changed", "When a terrible thing happened"],
        ["A monster appears and didn’t let John", "Come back to the beach again"],
        ["The monster is now becoming bigger", "John needs help to fight againt him!"],
        ["Help him to fight againts his fears", "And back to the place that he loves"]]
    
    lazy var story1: SKSpriteNode = {
        let node = SKSpriteNode(imageNamed: "Story1")
        node.position = CGPoint(x: 0, y: 90)
        node.setScale(0.75)
        return node
    }()
    
    lazy var story2: SKSpriteNode = {
        let node = SKSpriteNode(imageNamed: "Story2")
        node.position = CGPoint(x: 0, y: 160)
        node.setScale(0.70)
        return node
    }()
    
    lazy var story3: SKSpriteNode = {
        let node = SKSpriteNode(imageNamed: "Story3")
        node.position = CGPoint(x: 0, y: -50)
        node.setScale(0.71)
        return node
    }()
    
    lazy var story4: SKSpriteNode = {
        let node = SKSpriteNode(imageNamed: "Story4")
        node.position = CGPoint(x: 0, y: -100)
        node.setScale(0.71)
        return node
    }()
    
    lazy var story5: SKSpriteNode = {
        let node = SKSpriteNode(imageNamed: "Story5")
        node.position = CGPoint(x: 0, y: 0)
        node.setScale(0.75)
        return node
    }()
    
    var nextButton: SKButton = {
        var nextButton = SKLabelNode(text: "Next")
        nextButton.fontColor = .lightTextColor
        nextButton.fontName = "Futura"
        nextButton.fontSize = 23
        nextButton.color = .white
        
        let button = SKButton(label: nextButton)
        button.zPosition = 300
        return button
        
    }()
    var mainText: SKLabelNode = SKLabelNode(text: "test")
    var secondText: SKLabelNode = SKLabelNode(text: "test")
    var storyNumber: Int = 0
    
    override func didMove(to view: SKView) {
        sceneConfiguration()
        addElements()
    }
    
    private func firstNextButtonAction(){
        if storyNumber < 4 {
            storyNumber += 1
            self.mainText.text = self.storyData[self.storyNumber][0]
            self.secondText.text = self.storyData[self.storyNumber][1]
            nextButton.enable()
            
            switch storyNumber {
            case 1:
                switchThe(story1, for: story2)
            case 2:
                switchThe(story2, for: story3)
            case 3:
                switchThe(story3, for: story4)
            case 4:
                changeTextColorToLightMode()
                story5.zPosition = -10
                switchThe(story4, for: story5)
            default:
                break
            }
            
        } else {
            nextLevel(FirstScene(), transition: .crossFade(withDuration: 3))
        }
    }
    
    private func sceneConfiguration(){
        self.mainText.text = self.storyData[self.storyNumber][0]
        self.secondText.text = self.storyData[self.storyNumber][1]
        
        nextButton.enable()
        
        backgroundColor = SKColor.bgColor
        
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        mainText.position = CGPoint(x: 0, y: -170)
        mainText.fontName = "Futura Semibold"
        secondText.position = CGPoint(x: 0, y: -220)
        secondText.fontName = "Futura Semibold"
        
        nextButton.position = CGPoint(x: size.width/2 - 95, y: -size.height/2 + size.height/3.5)
        nextButton.addAction {
            self.firstNextButtonAction()
        }
        
    }
    
    private func addElements(){
        addChild(story1)
        addChild(mainText)
        addChild(secondText)
        addChild(nextButton)
    }
    
    func switchThe(_ a: SKSpriteNode
                   , for img : SKSpriteNode){
        a.removeFromParent()
        self.addChild(img)
    }
    
    func changeTextColorToLightMode(){
        self.nextButton.button.color = SKColor.darkTextColor
        self.mainText.fontColor = .darkTextColor
        self.secondText.fontColor = .darkTextColor
    }
}
