//
//  Item.swift
//  AdventureCourse
//
//  Created by rdls on 25/03/25.
//

import SpriteKit

class Item: SKSpriteNode {
    func setup() {
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width, height: self.size.height))
        // El tipo de entidad fisica al que ´Item´ pertenece
        physicsBody?.categoryBitMask = BitMask.item.rawValue
        // Para detectar si el personaje lo toca o lo aplasta.
        physicsBody?.contactTestBitMask = BitMask.character.rawValue | BitMask.crusher.rawValue
        // Para detectar colisiones con otros items o TODO: El Mapa.
        physicsBody?.collisionBitMask = BitMask.item.rawValue
        physicsBody?.allowsRotation = false
        physicsBody?.affectedByGravity = false
    }
    func isCollected() {
        self.physicsBody = nil
        self.alpha = 0
    }
}
