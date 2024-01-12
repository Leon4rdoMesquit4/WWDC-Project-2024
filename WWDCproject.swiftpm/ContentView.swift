import SwiftUI
import SpriteKit

struct ContentView: View {
    
    var scene: SKScene {
        let scene = MainMenu()
        scene.size = CGSize(width: 1024, height: 1366)
        scene.scaleMode = .aspectFill
        return scene
    }
    
    var body: some View {
        SpriteView(scene: scene)
            .ignoresSafeArea()
    }
}

class MainMenu: SKScene{
    
    var playButton: SKButton = {
        let playNode = SKLabelNode(text: "Play")
        playNode.color = .white
        playNode.fontSize = 70
        playNode.fontName = "Futura Bold"
        playNode.name = "playButton"
        
        let button = SKButton(label: playNode)
        return button
    }()
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.bgColor
        
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        let node = SKSpriteNode(imageNamed: "Menu")
        node.setScale(0.75)
        
        playButton.position = CGPoint(x: 0, y: -14)
        playButton.addAction {
            node.run(SKAction.wait(forDuration: 0.12)) {
                node.run(SKAction.rotate(byAngle: -4, duration: 2.5))
                node.run(SKAction.fadeAlpha(to: 0, duration: 2))
                self.playButton.run(SKAction.fadeAlpha(to: 0, duration: 2)){
                    node.removeFromParent()
                    self.playButton.removeFromParent()
                    self.nextLevel(StoryScene(), transition: .fade(with: .bgColor, duration: 2))
                }
            }
        }
        addChild(node)
        addChild(playButton)
    }
}
