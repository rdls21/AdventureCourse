//
//  Character.swift
//  AdventureCourse iOS
//
//  Created by rdls on 25/03/25.
//

import SpriteKit

class Villain: SKSpriteNode {
    /// Function needed to setup the Character
    func setup() {
        self.childNode(withName: "action")?.isHidden = true
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 125, height: 200))
        // Se asigna el cuerpo de fisicas de villano a si mismo
        physicsBody?.categoryBitMask = bitMask.villain.rawValue
        // Checara por contactos con el personaje principal
        physicsBody?.contactTestBitMask = bitMask.character.rawValue
        // physicsBody?.collisionBitMask = MUNDO
        physicsBody?.allowsRotation = false
        physicsBody?.affectedByGravity = false
    }
}
