//
//  Platforms.swift
//  AdventureCourse
//
//  Created by rdlsi on 26/03/25.
//

import SpriteKit

class Platforms: SKNode {
    // Creamos una variable para tener control sobre el nodo plataforma
    fileprivate var platform: SKTileMapNode!
    // Esto nos permitira tener el siguiente arbol
    // Platforms:
    //      - platforms
    //      // Y Agregar con código el siguiente nodo
    //      - Nodo para las Fisicas, generado con código
    /// Función que nos ayuda a configurar el nodo Plataformas
    func setup() {
        platform = childNode(withName: "TileMap") as? SKTileMapNode
        self.setupTileMapPhysics()
    }
    /// Función que genera un nodod de fisicas para nuestro tileMap
    private func setupTileMapPhysics() {
        guard let tileMap = platform else { NSLog("Platforms: Tile Not Found"); return }
        // BUGS!?
        let tileSize = tileMap.tileSize
        let halfTileWidth = tileSize.width / 2
        let halfTileHeight = tileSize.height / 2
        
        // Loop through every tile in the map
        for row in 0..<tileMap.numberOfRows {
            for column in 0..<tileMap.numberOfColumns {
                // Check if a tile exists at this position
                if tileMap.tileDefinition(atColumn: column, row: row) != nil {
                    // Create a physics body for this tile
                    let physicsBody = SKPhysicsBody(
                        rectangleOf: tileSize,
                        center: CGPoint(x: halfTileWidth, y: halfTileHeight)
                    )
                    // Configura las propiedades fisicas para este "azulejo/ficha" (tile)
                    physicsBody.isDynamic = false          // No es un objeto con movimiento
                    physicsBody.affectedByGravity = false // No debe afectarle la gravedad
                    physicsBody.friction = 0.5           // Fricción de la plataforma
                    // Asignamos una categoria para colisiones
                    physicsBody.categoryBitMask = BitMask.platfoms.rawValue
                    physicsBody.collisionBitMask = BitMask.character.rawValue
                    physicsBody.contactTestBitMask = BitMask.character.rawValue
                    
                    // Creamos el nodo de las fisicas para este azulejo a menos que
                    // Enseguida(column+1) y abajo(row+1) hay un nodo vacío, entonces no pintamos el nodo actual
                    if (tileMap.tileDefinition(atColumn: column+1, row: row) != nil &&
                        tileMap.tileDefinition(atColumn: column, row: row+1) != nil) {
                        let physicsNode = SKNode()
                        physicsNode.position = tileMap.centerOfTile(atColumn: column, row: row)
                        physicsNode.physicsBody = physicsBody
                        
                        // Añadimos las fisicas para este azulejo
                        tileMap.addChild(physicsNode)
                    }
                }
            }
        }
    }
}
