//
//  HighScores.swift
//  CrazyCalculate
//
//  Created by bobo on 14/11/4.
//  Copyright (c) 2014年 Xiong Bo. All rights reserved.
//

import Foundation
import SpriteKit

class HighScores: SKScene {
    
    var contentCreated: Bool = false
    
    override func didMoveToView(view: SKView) {
        
        if !self.contentCreated {
            self.contentCreated = true
            
            backgroundColor = SKColor.blackColor()
            scaleMode = SKSceneScaleMode.AspectFit
        }
        
    }
}