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
    
    
//MARK: didMove
    override func didMove(to view: SKView) {
        UIApplication.shared.isIdleTimerDisabled = true
        
        let spawnMountains = SKAction.run {self.createMountains()}
        let spawnClouds = SKAction.run {self.createClouds()}
        let wait = SKAction.wait(forDuration: 1)
        let startAll = SKAction.sequence([spawnMountains,spawnClouds,wait, spawnClouds])
        let runForever = SKAction.repeatForever(startAll)
        run(runForever)
        
        createGround()
        createCar()
        }
    
//MARK: Ground
    func createGround(){
        ground = SKSpriteNode(color: UIColor(red: 0, green: 1, blue: 0, alpha: 1), size: CGSize(width: self.frame.height, height: 100))
        ground.position = CGPoint(x: 0, y: -1 * (self.frame.height / 2))
        ground.physicsBody = SKPhysicsBody(rectangleOf: ground.size)
        ground.physicsBody?.categoryBitMask = PhysicsCategory.ground
        ground.physicsBody?.collisionBitMask = PhysicsCategory.car
        ground.physicsBody?.contactTestBitMask = PhysicsCategory.car
        ground.physicsBody?.affectedByGravity = false
        ground.physicsBody?.allowsRotation = false
        ground.physicsBody?.isDynamic = false
        ground.name = "ground"
        addChild(ground)
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
        cloudSpriteNode.position = CGPoint(x:ground.frame.width, y:Double.random(in: 0 ... (self.frame.height - (self.frame.height/4))) * Double.random(in: -1.0 ... 1.00))
        cloudSpriteNode.zPosition = CGFloat(-1 * (widhtClouds*100))
        cloudNode.addChild(cloudSpriteNode)

        let startMove = SKAction.moveTo(x: -1*(ground.frame.width * 2), duration: widhtClouds / 20)
        let afterMove = SKAction.removeFromParent()
        let moviment = SKAction.sequence([startMove,afterMove])

        addChild(cloudNode)
        cloudNode.run(moviment)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(view!.frame.maxY)
        let screenSize = UIScreen.main.bounds
        print(screenSize)
        print(self.frame.height)
    }
}
