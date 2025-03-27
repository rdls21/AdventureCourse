//
//  Character.swift
//  AdventureCourse iOS
//
//  Created by rdls on 25/03/25.
//

import SpriteKit

class Villain: SKSpriteNode {
    // To Handle Animations
    private var characterAtlas: SKTextureAtlas {
        return SKTextureAtlas(named: "DanAtlas")
    }
    /// Function needed to setup the Character
    func setup() {
        self.childNode(withName: "action")?.isHidden = true
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 100, height: 150))
        // Se asigna el cuerpo de fisicas de villano a si mismo
        physicsBody?.categoryBitMask = BitMask.villain.rawValue
        // Checara por contactos con el personaje principal
        physicsBody?.contactTestBitMask = BitMask.character.rawValue
        physicsBody?.allowsRotation = false
        physicsBody?.affectedByGravity = false
        
        self.startIdleAnimation()
    }
    private var villainIdleTextures: [SKTexture] {
        return [
            characterAtlas.textureNamed("dan_1"),
            characterAtlas.textureNamed("dan_2"),
            characterAtlas.textureNamed("dan_3")
        ]
    }
    private func startIdleAnimation() {
        let idleAnimation = SKAction.animate(with: villainIdleTextures, timePerFrame: 0.4)
        self.run(SKAction.repeatForever(idleAnimation), withKey: "VillainIdle")
    }
    // MARK: Acciones!
    func commitSelfHarm() {
        // El nombre de esta funcion es meramente comico, si conoces a alguien en riesgo de suicidio visita:
        self.physicsBody = nil
        self.alpha = 0
    }
}
