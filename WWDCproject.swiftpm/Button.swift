//
//  Button.swift
//  WWDCproject
//
//  Created by Leonardo Mesquita Alves on 07/01/24.
//

import SpriteKit

class SKButton: SKNode {
    let button: SKLabelNode
    private var mask: SKSpriteNode
    private var cropNode: SKCropNode
    private var action: (() -> Void)? = nil
    var isEnabled = true
    
    init(label: SKLabelNode) {
        button = label
        
        mask = SKSpriteNode(color: .black, size: button.frame.size)
//        mask.position.y = +20
        mask.alpha = 0
        mask.anchorPoint = CGPoint(x: 0.5, y: 0.25)
        mask.setScale(1.5)
        
        cropNode = SKCropNode()
        cropNode.maskNode = button
        cropNode.zPosition = 3
        cropNode.addChild(mask)
        
        super.init()
        
        isUserInteractionEnabled = true
        
        nodesConfig()
        addNodes()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func nodesConfig() {
        button.zPosition = 0
    }
    
    func addNodes() {
        addChild(button)
        addChild(cropNode)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isEnabled {
            mask.alpha = 0.5
            run(SKAction.scale(by: 1.05, duration: 0.05))
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isEnabled {
            for touch in touches {
                let location: CGPoint = touch.location(in: self)
                
                if button.contains(location){
                    mask.alpha = 0.5
                } else {
                    mask.alpha = 0
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isEnabled {
            for touch in touches {
                let location: CGPoint = touch.location(in: self)
                
                if button.contains(location){
                    disable()
                    if action != nil{
                        action!()
                    }
                    SKAction.sequence([SKAction.wait(forDuration: 0.2), SKAction.run {
                        self.enable()
                    }])
                } else {
                    setScale(1)
                }
            }
        }
        
        
    }
    
    func disable() {
        isEnabled = false
        mask.alpha = 0
        button.alpha = 0.1
    }
    
    func enable() {
        isEnabled = true
        mask.alpha = 0
        button.alpha = 1.0
        setScale(1)
    }
    
    func addAction(action: @escaping () -> Void){
        self.action = action
    }
}
