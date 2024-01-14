//
//  TextBox.swift
//  WWDCproject
//
//  Created by Leonardo Mesquita Alves on 13/01/24.
//

import SpriteKit

class GenericTextBox: SKNode{
    
    var backgroundT: SKSpriteNode = SKSpriteNode(color: SKColor.bgColor.withAlphaComponent(0.97), size: SceneConfigs.shared.size)
    
    var infoNode: SKSpriteNode = {
        let node = SKSpriteNode(imageNamed: "InfoAboutTheLevel")
        node.setScale(0.7)
        return node
    }()
    
    var nextButton: SKSpriteNode = SKSpriteNode(color: .red, size: CGSize(width: 216, height: 91.5))
    
    var title: String
    var text: String
    let titleLabel: SKLabelNode
    let textLabel: SKLabelNode
    
    var callback: (() -> Void)? = nil
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if nextButton.contains(location) {
                infoNode.run(SKAction.rotate(toAngle: -0.5, duration: 2))
                infoNode.run(SKAction.moveTo(y: 50, duration: 2))
                infoNode.run(SKAction.scale(to: 5, duration: 2))
                titleLabel.alpha = 0
                textLabel.alpha = 0
                
                run(SKAction.fadeAlpha(to: 0, duration: 2)){
                    self.removeFromParent()
                    if self.callback != nil{
                        self.callback!()
                    }
                }
            }
        }
    }
    
    init(title: String, text: String) {
        self.title = title
        self.text = text
        titleLabel = SKLabelNode(text: title)
        textLabel = SKLabelNode(text: text)
        
        super.init()

        titleLabel.fontColor = .white
        titleLabel.fontName = "Futura Bold"
        titleLabel.fontSize = 37.5
        titleLabel.position = CGPoint(x: -320, y: 40)
        titleLabel.horizontalAlignmentMode = .left
        
        textLabel.fontColor = .white
        textLabel.fontName = "Futura Regular"
        textLabel.fontSize = 22.5
        textLabel.position = CGPoint(x: -320, y: -55)
        textLabel.numberOfLines = 2
        textLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        textLabel.preferredMaxLayoutWidth = 600
        textLabel.horizontalAlignmentMode = .left
        
        nextButton.position = CGPoint(x: 290, y: -70)
        nextButton.alpha = 0
        
        addChild(backgroundT)
        addChild(infoNode)
        addChild(titleLabel)
        addChild(textLabel)
        addChild(nextButton)
        
        isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addAction(callback: @escaping () -> Void){
        self.callback = callback
    }
}
