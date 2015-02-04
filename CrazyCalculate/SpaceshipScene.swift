//
//  SpaceshipScene.swift
//  CrazyCalculate
//
//  Created by bobo on 14/11/4.
//  Copyright (c) 2014年 Xiong Bo. All rights reserved.
//

import Foundation
import SpriteKit

class SpaceshipScene: SKScene {

    override func didMoveToView(view: SKView) {
        self.backgroundColor = SKColor.redColor()
        self.scaleMode = SKSceneScaleMode.AspectFit
        
                    let sprite = SKSpriteNode(imageNamed:"Spaceship")
        
                    sprite.xScale = 0.5
                    sprite.yScale = 0.5
                    sprite.position = CGPointMake(10, 10)
        
                    let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
        
                    sprite.runAction(SKAction.repeatActionForever(action))
                    
                    self.addChild(sprite)

        let usedTimeLabel = SKLabelNode(fontNamed: "OpenSans-Bold")
        usedTimeLabel.position = CGPoint(x:CGRectGetMidX(frame), y:CGRectGetMidY(frame))
        usedTimeLabel.fontColor = SKColor.whiteColor()
        usedTimeLabel.fontSize = 48
        usedTimeLabel.text = "hello world"
        addChild(usedTimeLabel)
        
    }
    
}