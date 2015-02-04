//
//  Welcome.swift
//  CrazyCalculate
//
//  Created by bobo on 14/11/4.
//  Copyright (c) 2014年 Xiong Bo. All rights reserved.
//

import Foundation
import SpriteKit

class Welcome: SKScene {
    
    var contentCreated: Bool = false
    var opMode: CalcOp = .AddOp
    var numMode: NumMode = .Less10Mode

    let SubLess10Label = SKLabelNode(fontNamed: "OpenSans-Bold")
    let SubLess20Label = SKLabelNode(fontNamed: "OpenSans-Bold")
    let SubLess20_1Label = SKLabelNode(fontNamed: "OpenSans-Bold")
    
    let Less10Label = SKLabelNode(fontNamed: "OpenSans-Bold")
    let Less20Label = SKLabelNode(fontNamed: "OpenSans-Bold")
    let Less20_1Label = SKLabelNode(fontNamed: "OpenSans-Bold")

    let Add30Label = SKLabelNode(fontNamed: "OpenSans-Bold")
    let Sub30Label = SKLabelNode(fontNamed: "OpenSans-Bold")

    override func didMoveToView(view: SKView) {
        
        if !self.contentCreated {
            self.contentCreated = true
        
            backgroundColor = SKColor.blackColor()
            scaleMode = SKSceneScaleMode.AspectFit
            
            let title = SKLabelNode(fontNamed: "OpenSans-Bold")
            title.position = CGPoint(x:500, y:600)
            title.fontColor = SKColor.whiteColor()
            title.fontSize = 70
            title.text = "疯狂算术"
            title.name = "title"
            title.zRotation = -0.1
            addChild(title)
            
            let r1 = SKAction.rotateByAngle(0.2, duration:1)
            let r2 = SKAction.rotateByAngle(-0.2, duration:1)
            title.runAction(SKAction.repeatActionForever(SKAction.sequence([r1, r2])))
            
            SubLess10Label.position = CGPointMake(200, 450)
            SubLess10Label.fontColor = SKColor.whiteColor()
            SubLess10Label.fontSize = 45
            SubLess10Label.text = "-)1~10"
            SubLess10Label.name = "SubLess10"
            addChild(SubLess10Label)
            
            SubLess20Label.position = CGPointMake(500, 450)
            SubLess20Label.fontColor = SKColor.whiteColor()
            SubLess20Label.fontSize = 45
            SubLess20Label.text = "-)11-20"
            SubLess20Label.name = "SubLess20"
            addChild(SubLess20Label)
            
            SubLess20_1Label.position = CGPointMake(800, 450)
            SubLess20_1Label.fontColor = SKColor.whiteColor()
            SubLess20_1Label.fontSize = 45
            SubLess20_1Label.text = "-)1-20"
            SubLess20_1Label.name = "SubLess20_1"
            addChild(SubLess20_1Label)
            
            Less10Label.position = CGPointMake(200, 300)
            Less10Label.fontColor = SKColor.whiteColor()
            Less10Label.fontSize = 45
            Less10Label.text = "+)1~10"
            Less10Label.name = "Less10"
            addChild(Less10Label)
            
            Less20Label.position = CGPointMake(500, 300)
            Less20Label.fontColor = SKColor.whiteColor()
            Less20Label.fontSize = 45
            Less20Label.text = "+)11-20"
            Less20Label.name = "Less20"
            addChild(Less20Label)
            
            Less20_1Label.position = CGPointMake(800, 300)
            Less20_1Label.fontColor = SKColor.whiteColor()
            Less20_1Label.fontSize = 45
            Less20_1Label.text = "+)1-20"
            Less20_1Label.name = "Less20_1"
            addChild(Less20_1Label)
            
            Add30Label.position = CGPointMake(200, 150)
            Add30Label.fontColor = SKColor.whiteColor()
            Add30Label.fontSize = 45
            Add30Label.text = "+)30"
            Add30Label.name = "Add30"
            addChild(Add30Label)
            
            Sub30Label.position = CGPointMake(500, 150)
            Sub30Label.fontColor = SKColor.whiteColor()
            Sub30Label.fontSize = 45
            Sub30Label.text = "-)30"
            Sub30Label.name = "Sub30"
            addChild(Sub30Label)
            
            //updateNumMode()
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for touch in touches {
            let location = touch.locationInNode(self)
            var touchedNode = nodeAtPoint(location) as SKNode

            if touchedNode.name == "SubLess10" {
                opMode = .SubOp
                numMode = .Less10Mode
                //updateNumMode()
            }
            else if touchedNode.name == "SubLess20" {
                opMode = .SubOp
                numMode = .Less20Mode
                //updateNumMode()
            }
            else if touchedNode.name == "SubLess20_1" {
                opMode = .SubOp
                numMode = .Less20_1Mode
                //updateNumMode()
            }
            else if touchedNode.name == "Less10" {
                opMode = .AddOp
                numMode = .Less10Mode
                //updateNumMode()
            }
            else if touchedNode.name == "Less20" {
                opMode = .AddOp
                numMode = .Less20Mode
                //updateNumMode()
            }
            else if touchedNode.name == "Less20_1" {
                opMode = .AddOp
                numMode = .Less20_1Mode
                //updateNumMode()
            }
            else if touchedNode.name == "Add30" {
                opMode = .AddOp
                numMode = .Less30Mode
                //updateNumMode()
            }
            else if touchedNode.name == "Sub30" {
                opMode = .SubOp
                numMode = .Less30Mode
                //updateNumMode()
            }
            else {
                return
            }

            let sb: ScoreBoard = ScoreBoard(frame: CGRectMake(200, 100, 600, 500), opMode: opMode, numMode: numMode, showButton: 1)
            addChild(sb)
        }
    }
    
    func runExec() {
        let next: SKScene = GameScene.init(size: size, calcMode: .ExerMode, numMode: numMode, calcOp: opMode)
        let doors: SKTransition = SKTransition.doorsOpenHorizontalWithDuration(0.5)
        view?.presentScene(next, transition: doors)
    }
    
    func runTest() {
        let next: SKScene = GameScene.init(size: size, calcMode: .TestMode, numMode: numMode, calcOp: opMode)
        let doors: SKTransition = SKTransition.doorsOpenHorizontalWithDuration(0.5)
        view?.presentScene(next, transition: doors)
    }
    
    func updateNumMode() {
        SubLess10Label.runAction(SKAction.scaleTo(1.0, duration: 0.3))
        SubLess20Label.runAction(SKAction.scaleTo(1.0, duration: 0.3))
        SubLess20_1Label.runAction(SKAction.scaleTo(1.0, duration: 0.3))
        Less10Label.runAction(SKAction.scaleTo(1.0, duration: 0.3))
        Less20Label.runAction(SKAction.scaleTo(1.0, duration: 0.3))
        Less20_1Label.runAction(SKAction.scaleTo(1.0, duration: 0.3))

        if opMode == .AddOp {
            switch numMode {
            case .Less10Mode:
                Less10Label.runAction(SKAction.scaleTo(2.0, duration: 0.3))
            case .Less20Mode:
                Less20Label.runAction(SKAction.scaleTo(2.0, duration: 0.3))
            case .Less20_1Mode:
                Less20_1Label.runAction(SKAction.scaleTo(2.0, duration: 0.3))
            case .Less30Mode:
                Add30Label.runAction(SKAction.scaleTo(2.0, duration: 0.3))
            }
        }
        else if opMode == .SubOp {
            switch numMode {
            case .Less10Mode:
                SubLess10Label.runAction(SKAction.scaleTo(2.0, duration: 0.3))
            case .Less20Mode:
                SubLess20Label.runAction(SKAction.scaleTo(2.0, duration: 0.3))
            case .Less20_1Mode:
                SubLess20_1Label.runAction(SKAction.scaleTo(2.0, duration: 0.3))
            case .Less30Mode:
                Sub30Label.runAction(SKAction.scaleTo(2.0, duration: 0.3))
            }
        }
    }
    
}