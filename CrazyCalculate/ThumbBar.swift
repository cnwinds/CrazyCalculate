//
//  ThumbBar.swift
//  CrazyCalculate
//
//  Created by bobo on 14/11/8.
//  Copyright (c) 2014年 Xiong Bo. All rights reserved.
//

import Foundation
import SpriteKit


enum ThumbBarColor: Int {
    case
        TBColor1 = 0,
        TBColor2 = 1
}

class ThumbBar: SKNode {
    
    var bluePath: CGMutablePath
    var redPath: CGMutablePath
    let bluePathNode: SKShapeNode
    let redPathNode: SKShapeNode
    let thumbBarNode: SKShapeNode
    
    let myFrame: CGRect
    var count: Int
    var curIndex: Int
    var itemWidth: CGFloat
    
    init(frame: CGRect, count: Int = 10) {
        myFrame = frame
        self.count = count
        curIndex = 0
        
        itemWidth = myFrame.width / CGFloat(count)

        thumbBarNode = SKShapeNode(rect: frame, cornerRadius: 3)
        thumbBarNode.strokeColor = SKColor.whiteColor()
        thumbBarNode.lineWidth = 2.0
        thumbBarNode.zPosition = 1
        thumbBarNode.alpha = 1
        
        bluePath = CGPathCreateMutable()
        CGPathMoveToPoint(bluePath, nil, -10, -10)
        CGPathAddLineToPoint(bluePath, nil, -10, -10)
        bluePathNode = SKShapeNode()
        bluePathNode.path = bluePath
        bluePathNode.strokeColor = SKColor.greenColor()
        bluePathNode.lineWidth = itemWidth
        bluePathNode.zPosition = 1
        thumbBarNode.addChild(bluePathNode)

        redPath = CGPathCreateMutable()
        CGPathMoveToPoint(redPath, nil, -10, -10)
        CGPathAddLineToPoint(redPath, nil, -10, -10)
        redPathNode = SKShapeNode()
        redPathNode.path = redPath
        redPathNode.strokeColor = SKColor.redColor()
        redPathNode.lineWidth = itemWidth
        redPathNode.zPosition = 1
        thumbBarNode.addChild(redPathNode)
        
        super.init()
        
        addChild(thumbBarNode)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func clear() {
        curIndex = 0
        redPath = CGPathCreateMutable()
        CGPathMoveToPoint(redPath, nil, -10, -10)
        CGPathAddLineToPoint(redPath, nil, -10, -10)
        redPathNode.path = redPath
        bluePath = CGPathCreateMutable()
        CGPathMoveToPoint(bluePath, nil, -10, -10)
        CGPathAddLineToPoint(bluePath, nil, -10, -10)
        bluePathNode.path = bluePath
    }
    
    func addResult(tbColor: ThumbBarColor) {
        if tbColor == .TBColor1 {
            CGPathMoveToPoint(bluePath, nil, myFrame.minX + CGFloat(curIndex) * itemWidth + itemWidth / 2, myFrame.minY)
            CGPathAddLineToPoint(bluePath, nil, myFrame.minX + CGFloat(curIndex) * itemWidth + itemWidth / 2, myFrame.maxY)
            bluePathNode.path = bluePath
        }
        else {
            CGPathMoveToPoint(redPath, nil, myFrame.minX + CGFloat(curIndex) * itemWidth + itemWidth / 2, myFrame.minY)
            CGPathAddLineToPoint(redPath, nil, myFrame.minX + CGFloat(curIndex) * itemWidth + itemWidth / 2, myFrame.maxY)
            redPathNode.path = redPath
        }
        curIndex++
        thumbBarNode.zPosition = 1
    }
    
    func setCount(count: Int) {
        self.count = count
        itemWidth = myFrame.width / CGFloat(count)
        bluePathNode.lineWidth = itemWidth
        redPathNode.lineWidth = itemWidth
    }
}