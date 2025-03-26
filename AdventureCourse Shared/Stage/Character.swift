//
//  Character.swift
//  AdventureCourse iOS
//
//  Created by rdls on 25/03/25.
//

import SpriteKit

class Character: SKSpriteNode {
    // To Handle Animations
    private var characterAtlas: SKTextureAtlas {
        return SKTextureAtlas(named: "AlexAtlas")
    }
    private var playerIdleTextures: [SKTexture] {
        return [
            characterAtlas.textureNamed("alex_1"),
            characterAtlas.textureNamed("alex_2"),
            characterAtlas.textureNamed("alex_3"),
            characterAtlas.textureNamed("alex_4")
        ]
    }
    /// Funcion para configurar el personaje
    func setup() {
        // Generamos un cuerpo de fisicas para interacciónes del personaje
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 200, height: 300))
        // El tipo de entidad fisica al que ´Character´ pertenece
        physicsBody?.categoryBitMask = bitMask.character.rawValue
        // Para detectar si el personaje interactúa con el item.
        physicsBody?.contactTestBitMask = bitMask.item.rawValue
        // Para detectar si el personaje colisiona con si mismo.
        physicsBody?.collisionBitMask = bitMask.character.rawValue
        // TODO: Contacto con el mundo!
        physicsBody?.allowsRotation = false
        physicsBody?.affectedByGravity = false
        // Cuerpo de físicas para cuando el personaje esta sobre un villano o un item
        let crusher = SKShapeNode()
        crusher.position.y = -350
        crusher.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 200, height: 200))
        // Este cuerpo de fisicas es de tipo Crusher
        crusher.physicsBody?.categoryBitMask = bitMask.crusher.rawValue
        // Va a tener pruebas de contacto con el villano
        crusher.physicsBody?.contactTestBitMask = bitMask.villain.rawValue
        // colisionara únicamente consigomismo
        crusher.physicsBody?.collisionBitMask = bitMask.crusher.rawValue
        crusher.physicsBody?.affectedByGravity = false
        self.addChild(crusher)
        self.startIdleAnimation()
    }
    
    private func startIdleAnimation() {
        let idleAnimation = SKAction.animate(with: playerIdleTextures, timePerFrame: 0.1)
        self.run(SKAction.repeatForever(idleAnimation), withKey: "CharacterIdle")
    }
}
