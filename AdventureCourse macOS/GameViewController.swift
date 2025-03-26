//
//  GameViewController.swift
//  adventureCurse macOS
//
//  Created by rdlsi on 25/03/25.
//

import Cocoa
import SpriteKit
import GameplayKit

class GameViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = GameScene.newGameScene()
        
        // Present the scene
        let skView = self.view as! SKView
        skView.presentScene(scene)
        // Booleano que indica si las relaciones padre-hijo afectan el orden de renderizado.
        skView.ignoresSiblingOrder = true
        // Muestra controles de desarrollo en ventana.
        skView.showsFPS = true
        skView.showsPhysics = true
        skView.showsNodeCount = true
    }

}

