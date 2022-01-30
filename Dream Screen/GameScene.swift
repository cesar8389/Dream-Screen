//
//  GameScene.swift
//  Dream Screen
//
//  Created by Cesar Augusto Barros on 29/01/22.
//

import SpriteKit
import GameplayKit

struct PhysicsCategory {
    static let car : UInt32 = 0x1 << 1
    static let ground : UInt32 = 0x1 << 2
}

class GameScene: SKScene {
    var car =  SKSpriteNode()
    var ground = SKSpriteNode()
    let screenSize = UIScreen.main.bounds
    
//MARK: didMove
    override func didMove(to view: SKView) {
        UIApplication.shared.isIdleTimerDisabled = true
//        let spawnGround = SKAction.run {self.createGround()}
        let spawnMountains = SKAction.run {self.createMountains()}
        let spawnClouds = SKAction.run {self.createClouds()}
        let wait = SKAction.wait(forDuration: 1)
        let startAll = SKAction.sequence([spawnMountains,spawnClouds,wait, spawnClouds])
        let runForever = SKAction.repeatForever(startAll)
        run(runForever)
        
//        let wait = SKAction.wait(forDuration: 10)
//        let startGround = SKAction.sequence([wait,spawnGround])
//        let runForever = SKAction.repeatForever(startGround)
//        run(runForever)
        createGround()
        createCar()
        }
    
//MARK: Ground
    func createGround(){
        ground = SKSpriteNode(color: UIColor(red: 0, green: 0, blue: 0, alpha: 1), size: CGSize(width: screenSize.width * 2, height: 100))
//        let texture = SKTexture(imageNamed: "ground")
//        ground = SKSpriteNode(texture: texture)
//        ground.size = CGSize(width: screenSize.width * 2, height: 100)
        ground.position = CGPoint(x:0, y:ground.frame.height/2 - frame.height/2)
        ground.physicsBody = SKPhysicsBody(rectangleOf: ground.size)
        ground.physicsBody?.categoryBitMask = PhysicsCategory.ground
        ground.physicsBody?.collisionBitMask = PhysicsCategory.car
        ground.physicsBody?.contactTestBitMask = PhysicsCategory.car
        ground.physicsBody?.affectedByGravity = false
        ground.physicsBody?.allowsRotation = false
        ground.physicsBody?.isDynamic = false
        ground.name = "ground"
//        let texture = SKTexture(imageNamed: "ground")
//        let setTexture = SKAction.setTexture(texture, resize: true)
//        let startMove = SKAction.moveTo(x: -1*(screenSize.width * 2), duration: 10)
//        let afterMove = SKAction.removeFromParent()
//        let moviment = SKAction.sequence([setTexture,startMove,afterMove])
        addChild(ground)
//        ground.run(moviment)
    }
//MARK: Car
    func createCar(){
        car = SKSpriteNode(color: UIColor(red: 1, green: 0, blue: 0, alpha: 1), size: CGSize(width: 50, height: 30))
        car.position = CGPoint(x: -100, y: ground.position.y + car.frame.height)
        car.physicsBody = SKPhysicsBody(rectangleOf: car.size)
        car.physicsBody?.categoryBitMask = PhysicsCategory.car
        car.physicsBody?.collisionBitMask = PhysicsCategory.ground
        car.physicsBody?.contactTestBitMask = PhysicsCategory.ground
        car.physicsBody?.affectedByGravity = true
        car.physicsBody?.allowsRotation = false
        car.physicsBody?.isDynamic = true
        car.name = "car"
        self.addChild(car)
    }
    
//MARK: Mountains
    func createMountains(){
        let widhtMountain:Double = Double.random(in: 1 ... 4) * 3 * 100.0
        let heightMountain:Double = widhtMountain/6.7
        let mountainNode = SKNode()
        let mountainSpriteNode = SKSpriteNode(imageNamed: "mountain")
        mountainSpriteNode.size = CGSize(width: widhtMountain, height: heightMountain)
        mountainSpriteNode.position = CGPoint(x:ground.frame.width, y:heightMountain/2 + ground.position.y + (ground.frame.height/2))
        mountainSpriteNode.zPosition = CGFloat(-1 * widhtMountain)
        mountainNode.addChild(mountainSpriteNode)
        
        let startMove = SKAction.moveTo(x: -1*(ground.frame.width * 2), duration: widhtMountain / 100)
        let afterMove = SKAction.removeFromParent()
        let moviment = SKAction.sequence([startMove,afterMove])
        
        addChild(mountainNode)
        mountainNode.run(moviment)
    }

//MARK: Clouds
    func createClouds(){
        let clouds = ["cloud1", "cloud2"]
        let selectCloud:String = clouds.randomElement()!
        let widhtClouds:Double = Double(Int.random(in: 1 ... 4) * 8 + 100)
        let heightClouds = widhtClouds/2
        let cloudNode = SKNode()
        let cloudSpriteNode = SKSpriteNode(imageNamed: selectCloud)
        cloudSpriteNode.size = CGSize(width: widhtClouds, height: heightClouds)
        cloudSpriteNode.position = CGPoint(x:ground.frame.width, y:Double.random(in: 0 ... screenSize.width) * Double.random(in: -1.0 ... 1.00))
        cloudSpriteNode.zPosition = CGFloat(-1 * widhtClouds)
        cloudNode.addChild(cloudSpriteNode)

        let startMove = SKAction.moveTo(x: -1*(ground.frame.width * 2), duration: widhtClouds / 20)
        let afterMove = SKAction.removeFromParent()
        let moviment = SKAction.sequence([startMove,afterMove])

        addChild(cloudNode)
        cloudNode.run(moviment)
    }
}
