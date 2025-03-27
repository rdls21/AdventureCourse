//
//  Character.swift
//  AdventureCourse iOS
//
//  Created by rdls on 25/03/25.
//

import SpriteKit

class Character: SKSpriteNode {
    // Control de vida del personaje
    var isDead = false
    // To handle direction states
    private var isFacingLeft: Bool = false
    // Variable del cuerpo de fisicas de nuestro pisador
    private var crusherNode: SKShapeNode!
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
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 150, height: 250))
        // El tipo de entidad fisica al que ´Character´ pertenece
        physicsBody?.categoryBitMask = BitMask.character.rawValue
        // Para detectar si el personaje interactúa con el item, se llama la funcion dentro de Physics.swift.
        physicsBody?.contactTestBitMask = BitMask.item.rawValue
        // Para detectar si el personaje colisiona con si mismo.
        physicsBody?.collisionBitMask = BitMask.character.rawValue
        // TODO: Contacto con el mundo!
        physicsBody?.allowsRotation = false
        // Para que nuestro personaje pueda caer encima de las plataformas.
        physicsBody?.affectedByGravity = true
        
        // Cuerpo de físicas para cuando el personaje esta sobre un villano o un item
        self.crusherNode = SKShapeNode()
        crusherNode.position.y = -400
        crusherNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 400, height: 200))
        // Este cuerpo de fisicas es de tipo Crusher
        crusherNode.physicsBody?.categoryBitMask = BitMask.crusher.rawValue
        // Va a tener pruebas de contacto con el villano
        crusherNode.physicsBody?.contactTestBitMask = BitMask.villain.rawValue | BitMask.platfoms.rawValue
        // colisionara únicamente consigomismo
        crusherNode.physicsBody?.collisionBitMask = BitMask.crusher.rawValue
        // Hacemos que no cambie de posicion nuestro colisionador
        crusherNode.physicsBody?.isDynamic = false
        // No permitimos que rote sobre su propio eje
        //crusher.physicsBody?.allowsRotation = false
        // No le afecta la gravedad
        //crusher.physicsBody?.affectedByGravity = false
        self.addChild(crusherNode)
        self.startIdleAnimation()
    }
    private func startIdleAnimation() {
        let idleAnimation = SKAction.animate(with: playerIdleTextures, timePerFrame: 0.1)
        self.run(SKAction.repeatForever(idleAnimation), withKey: "CharacterIdle")
    }
    private func startWalkAnimation() {
        // Aqui va el codigo para empezar una animacion de caminar
    }
    
    func updateCrusher() {
        crusherNode.position.x = 0
        crusherNode.position.y = -400
    }
    // MARK: Acciones!
    func moveLeft(isPressed: Bool) {
        if !isFacingLeft && isPressed {
            let mirrowed = CGSize(width: self.size.width * -1, height: self.size.height)
            self.size = mirrowed
            isFacingLeft = true
        } else if isFacingLeft && !isPressed {
            isFacingLeft = false
            let mirrowed = CGSize(width: self.size.width * -1, height: self.size.height)
            self.size = mirrowed
        }
    }
    /// Funcion que se encarga de eliminar al personaje
    func die() {
        // Accion para cambiarle el color al personaje
        let turnGray = SKAction.sequence([
            SKAction.colorize(with: .black, colorBlendFactor: 1.0, duration: 0.1)
        ])
        // Quitamos todas las acciones del personaje
        self.removeAllActions()
        // Eliminamos todas las fisicas del personaje
        self.crusherNode.removeFromParent()
        // Cambiamos el estado del personaje para que ya no pueda moverse
        self.isDead = true
        // Realizamos la animacion de cambiar el color al personaje
        self.run(turnGray)
    }
    func dieByFalling() {
        // Accion para cambiarle el color al personaje
        let turnGray = SKAction.sequence([
            SKAction.colorize(with: .black, colorBlendFactor: 1.0, duration: 0.1)
        ])
        // Quitamos todas las acciones del personaje
        self.removeAllActions()
        // Eliminamos todas las fisicas del personaje
        self.crusherNode.removeFromParent()
        self.physicsBody = nil
        // Cambiamos el estado del personaje para que ya no pueda moverse
        self.isDead = true
        // Realizamos la animacion de cambiar el color al personaje
        self.run(turnGray)
    }
}
