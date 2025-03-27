//
//  Physics.swift
//  AdventureCourse
//
//  Created by rdls on 25/03/25.
//

import SpriteKit

enum BitMask: UInt32 {
    case unknown = 0x0
    /// Bitmask para las colisiones de nuestro personaje, 001
    case character = 0x1
    /// Bitmask para las colisiones con el nodo de aplastar, 010
    case crusher = 0x2
    /// Bitmask para las colisiones con el nodo villano, 011
    case villain = 0x3
    /// Bitmask para las colisiones con los items, 100
    case item = 0x4
    /// Bitmask para las colisiones con el suelo,d 111
    case platfoms = 0x7
}

// Extension de la escena de juego que nos ayudará a controlar las físicas del juego.
extension GameScene: SKPhysicsContactDelegate {
    // Función que se ejecuta cada que se detecta una colisión con otro cuerpo de fisícas.
    func didBegin(_ contact: SKPhysicsContact) {
        let bitmaskA: BitMask = BitMask(rawValue: contact.bodyA.categoryBitMask) ?? .unknown
        let bitmaskB: BitMask = BitMask(rawValue: contact.bodyB.categoryBitMask) ?? .unknown
        // Personaje tiene contacto con el suelo
        if bitmaskA == .platfoms && bitmaskB == .character {
            self.canJump = true
        }
        // Personaje Aplasta Villano
        if bitmaskA == .crusher && bitmaskB == .villain {
            self.killVillain()
        }
        // Personaje toca Villano
        if bitmaskA == .character && bitmaskB == .villain {
            self.killCharacter()
        }
        // Personaje encuentra item
        if bitmaskA == .character && bitmaskB == .item {
            switch contact.bodyB.node?.name {
            case "itmChest", "itmHiddenChest":
                print("Physics: Encontro el cofre!")
            case "EndMark":
                print("Physics: Encontro la bandera del final!")
            case .none:
                NSLog("Physics: Encontro un Item sin reconocer \(String(describing: contact.bodyB.node?.name))")
            case .some(let atm):
                NSLog(atm.description)
            }
            self.itemFound(name: contact.bodyB.node?.name ?? "")
        }
    }
}
