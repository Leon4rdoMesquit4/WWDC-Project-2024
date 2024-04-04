import SwiftUI
import SpriteKit

struct ContentView: View {
    
    // Creating the SKScene instance to use in the SwiftUI View
    var scene: SKScene {
        let scene = MainMenu()
        scene.size = SceneConfiguration.shared.size
        scene.scaleMode = .aspectFill
        return scene
    }
    
    //Adding and configurating the SpriteView 
    var body: some View {
        SpriteView(scene: scene)
            .ignoresSafeArea()
            .statusBarHidden()
    }
}

//Creating the main screen where the playButton will be located
class MainMenu: SKScene{
    
    //PlayButton Configuration
    var playButton: SKButton = {
        let playNode = SKLabelNode(text: "Play")
        playNode.color = .white
        playNode.fontSize = 70
        playNode.fontName = "Futura Bold"
        playNode.name = "playButton"
        
        let button = SKButton(label: playNode)
        return button
    }()
    
    //With AudioNode I'm creating the sound system of the game
    var backgroundMusic: SKAudioNode!
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.bgColor
        
        //As a pattern I'm centralizing the nodes to help me moving them to their especificy places
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        let node = SKSpriteNode(imageNamed: "Menu")
        node.setScale(0.75)
        
        playButton.position = CGPoint(x: 0, y: -14)
        
        //Adding the action to move to another scene with a method inside the SKButton class
        playButton.addAction {
            node.run(SKAction.wait(forDuration: 0.12)) {
                node.run(SKAction.rotate(byAngle: -4, duration: 2.5))
                node.run(SKAction.fadeAlpha(to: 0, duration: 2))
                self.backgroundMusic.run(.changeVolume(to: 0, duration: 2.5))
                self.playButton.run(SKAction.fadeAlpha(to: 0, duration: 2)){
                    
                    node.removeFromParent()
                    self.playButton.removeFromParent()
                    self.nextLevel(StoryScene(), transition: .fade(with: .bgColor, duration: 2))
                    
                }
            }
        }
        
        //This is the way I use to get the song from resources and pass to the background music variable
        if let musicURL = Bundle.main.url(forResource: "music1", withExtension: "m4a") {
            backgroundMusic = SKAudioNode(url: musicURL)
            addChild(backgroundMusic)
        }
        
        //It let the backgroung sound repeat forever
        backgroundMusic.autoplayLooped = true
        
        backgroundMusic.run(.changeVolume(to: 0.5, duration: 0))
        
        //Adding nodes
        addChild(node)
        addChild(playButton)
    }
}
