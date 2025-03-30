//
//  GameScene.swift
//  adventureCurse Shared
//
//  Created by rdlsi on 25/03/25.
//

import SpriteKit

// Control lateral de movimiento del usuario
enum Direction {
    case idle
    case right
    case left
}

class GameScene: SKScene {
    func killVillain() {
        self.villain.commitSelfHarm()
    }
    func killCharacter() {
        self.character.die()
        label?.text = String("Fuiste Eliminado")
        physicsWorld.speed = 0
    }
    func itemFound(name: String) {
        items.filter({ $0.name == name }).first!.isCollected()
        switch name {
        case "itmChest":
            gatheredPoints += 5
            label?.text = String("Puntos: \(gatheredPoints)")
        case "itmHiddenChest":
            gatheredPoints += 15
            label?.text = String("Puntos: \(gatheredPoints)")
        case "EndMark":
            // MARK: Fin del Juego.
            // Mostrar un mensaje final dependiendo de los puntos recolectados.
            character.die()
            // Hacer una suma de los puntos que tenemos para mostrar un mensaje personalizado.
            if gatheredPoints < 20 {
                label?.text = String("Puedes Hacerlo Mejor")
            } else {
                label?.text = String("Conseguiste todos los puntos!")
            }
        default:
            break
        }
    }
    // Gameplay control
    /// Variable para llevar un control de puntaje
    fileprivate var gatheredPoints: Int16 = 0
    /// Character Movement
    fileprivate var characterDir: Direction = .idle
    var canJump: Bool = false
    // Character, Villain, Items and Platforms
    /// Variable para tener control del nodo de nuestro Personaje dentro del GameScene
    fileprivate var character: Character!
    /// Variable para tener control del nodo de nuestro Villano dentro del GameScene
    fileprivate var villain: Villain!
    /// Variable para tener control del nodo de item o items
    fileprivate var items: [Item]!
    /// Variable para tener el control de las plataformas dentro del GameScene
    fileprivate var platforms: Platforms?
    /// Variable para mostrar el sistema de puntos dentro del GameScene
    fileprivate var label: SKLabelNode?
    // Función para crear un nuevo escenario de juego
    class func newGameScene() -> GameScene {
        // Load 'GameScene.sks' as an SKScene.
        guard let scene = SKScene(fileNamed: "GameScene") as? GameScene else {
            print("GameScene: Failed to load GameScene.sks")
            abort()
        }
        // Set the scale mode to scale to fit the window
        scene.scaleMode = .aspectFill
        return scene
    }
    // Funcion que nos ayuda a realizar las configuracio nes necesarias para el GameScene
    func setUpScene() {
        // Buscamos el nodo Label para mostrar el puntaje al jugador.
        self.label = self.childNode(withName: "//PointsLabel") as? SKLabelNode
        if let _ = self.label {
            // Si entra aca, significa que logramos conectar correctamente el codigo con el GameScene
            
        }
        // Create shape node to use during mouse interaction
        //let w = (self.size.width + self.size.height) * 0.05
        // self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        // Conectamos nuestra variable plataformas con el nodo Plataformas del GameScene
        self.platforms = self.childNode(withName: "PlatformsNode") as? Platforms
        
        if let platforms = self.platforms {
            platforms.setup()
        }
    }
    // Entramos a esta vista.
    override func didMove(to view: SKView) {
        // Designamos el delegado de fisicas para que nuestro codigo pueda escuchar eventos
        physicsWorld.contactDelegate = self
        self.setUpScene()
        // Conectamos el personaje principal con nuestra variable
        character = childNode(withName: "Alex") as? Character
        character.setup()
        // Conectamos el villano con nuestra variable
        villain = childNode(withName: "Dan") as? Villain
        villain.setup()
        // Conectamos los item del GameScene con la variable de items
        items = childNode(withName: "Items")?.children as? [Item]
        for item in items {
            item.setup()
            // Aca adentro se encuentra la bandera de finalizacion
        }
        // Configuramos los items animables
        //items.filter({ $0.name == "Nombre del Item Animable" }).first!.setupWith(
        //  folder: "", frames: [""])
        
    }
    
    // Ciclo de renderizado del juego
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        // Validar que el jugador se encuentre dentro del mapa del juego, si no, eliminarlo
        if character.isDead { return }
        if character.position.y < -1280 {
            // Entró a la Kill Zone
            character.dieByFalling()
            label?.text = String("Sufriste una caída")
        }
        // Controlar el movimiento del personaje
        if character.isDead { return }
        switch characterDir {
        case .idle:
            break
        case .left:
            // Voltear el personaje para que se mueva a la izquierda
            character.moveLeft(isPressed: true)
            // Movemos el personaje a la izquierda
            character.position.x -= 5
        case .right:
            // Movemos el personaje a la derecha
            character.position.x += 5
        }
        // Actualizar la posicion del aplastador
        character.updateCrusher()
        // Seguimiento del personaje con la camara
        let xOffset = character.position.x - (camera?.position.x)!+40
        camera?.position.x += 1 * ((xOffset-40)/40)
        let yOffset = character.position.y - (camera?.position.y)!
        camera?.position.y += 1 * ((yOffset)/30)
    }
    
    
}

#if os(iOS) || os(tvOS)
// Touch-based event handling
extension GameScene {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let label = self.label {
            //label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        
        for t in touches {
            //self.makeSpinny(at: t.location(in: self), color: SKColor.green)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            //self.makeSpinny(at: t.location(in: self), color: SKColor.blue)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            //self.makeSpinny(at: t.location(in: self), color: SKColor.red)
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            //self.makeSpinny(at: t.location(in: self), color: SKColor.red)
        }
    }
    
   
}
#endif

#if os(OSX)
// Mouse-based event handling
extension GameScene {
    override func mouseDown(with event: NSEvent) {
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        // self.makeSpinny(at: event.location(in: self), color: SKColor.green)
    }
    
    override func mouseDragged(with event: NSEvent) {
        // self.makeSpinny(at: event.location(in: self), color: SKColor.blue)
    }
    
    override func mouseUp(with event: NSEvent) {
        // self.makeSpinny(at: event.location(in: self), color: SKColor.red)
    }
    // Control del juego mediante el teclado (A, D, SpaceBar)
    override func keyDown(with event: NSEvent) {
        for codeUnit in event.characters!.utf16 {
            // Tecla letra A
            if codeUnit == 97 {
                self.characterDir = .left
            }
            // Tecla letra D
            if codeUnit == 100 {
                //character.moveRight(self)
                self.characterDir = .right
            }
            // Tecla Espacio
            if codeUnit == 32 {
                // if Can Jump
                if canJump {
                    self.character.physicsBody?.applyImpulse(CGVectorMake(0, 1800))
                }
                canJump = false
            }
        }
    }
    override func keyUp(with event: NSEvent) {
        for codeUnit in event.characters!.utf16 {
            // Tecla letra A
            if codeUnit == 97 {
                character.moveLeft(isPressed: false)
                self.characterDir = .idle
            }
            // Tecla letra D
            if codeUnit == 100 {
                //character.moveRight(self)
                self.characterDir = .idle
            }
            // Tecla Espacio
            if codeUnit == 32 {
                //pauseTheLevel()
            }
        }
    }
}
#endif

