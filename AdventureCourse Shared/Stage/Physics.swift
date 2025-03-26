//
//  Physics.swift
//  AdventureCourse
//
//  Created by rdls on 25/03/25.
//

import SpriteKit

enum bitMask: UInt32 {
    /// Bitmask para las colisiones de nuestro personaje, 001
    case character = 0x1
    /// Bitmask para las colisiones con el nodo de aplastar, 010
    case crusher = 0x2
    /// Bitmask para las colisiones con el nodo villano, 011
    case villain = 0x3
    /// Bitmask para las colisiones con los items, 100
    case item = 0x4
}

// Extension de la escena de juego que nos ayudará a controlar las físicas del juego.
extension GameScene: SKPhysicsContactDelegate {
    // Función que se ejecuta cada que se detecta una colisión con otro cuerpo de fisícas.
    func didBegin(_ contact: SKPhysicsContact) {
        // TODO
    }
}
