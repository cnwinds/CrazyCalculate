//
//  ScoreBoard.swift
//  CrazyCalculate
//
//  Created by bobo on 14/11/18.
//  Copyright (c) 2014年 Xiong Bo. All rights reserved.
//

import Foundation
import SpriteKit

class ScoreBoard : SKNode {
    
    let myFrame: CGRect
    let board: SKShapeNode
    let rank: ScoreRank?
    var clearLabel: SKLabelNode
    
    var opMode: CalcOp = .AddOp
    var numMode: NumMode = .Less10Mode

    init(frame: CGRect, opMode: CalcOp, numMode: NumMode, showButton: Int) {
        self.rank = rankMng.getRank(opMode, numMode: numMode)
        self.opMode = opMode
        self.numMode = numMode
        
        myFrame = frame
        board = SKShapeNode(rect: frame, cornerRadius: 3)
        board.zPosition = 5
        var kbTexutre = SKTexture(imageNamed: "rank.png")
        var bg = SKSpriteNode(texture: kbTexutre, color: nil, size: CGSizeMake(frame.width, frame.height))
        bg.position = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame))
        bg.zPosition = 5
        
        clearLabel = SKLabelNode()
        clearLabel.position = CGPointMake(myFrame.width + 120, myFrame.height + 40)
        clearLabel.fontColor = SKColor.whiteColor()
        clearLabel.fontSize = 30
        clearLabel.text = "clear"
        clearLabel.name = "clear"
        clearLabel.zPosition = 5

        super.init()

        addChild(bg)

        board.strokeColor = SKColor.whiteColor()
        board.lineWidth = 2.0
        board.zPosition = 2
        board.alpha = 1
        addChild(board)

        //addChild(clearLabel)

        if showButton == 1 {
            let exec = SKLabelNode()
            exec.position = CGPoint(x:270, y:120)
            exec.fontColor = SKColor.whiteColor()
            exec.fontSize = 48
            exec.text = "练习"
            exec.name = "exec"
            exec.zPosition = 5
            addChild(exec)
            
            let test = SKLabelNode()
            test.position = CGPoint(x:730, y:120)
            test.fontColor = SKColor.whiteColor()
            test.fontSize = 48
            test.text = "测试"
            test.name = "test"
            test.zPosition = 5
            addChild(test)
        }
        
        userInteractionEnabled = true

        if rank == nil {
            return
        }
        
        let title: SKLabelNode = SKLabelNode()
        title.fontSize = 50
        title.fontColor = SKColor.whiteColor()
        title.text = rank!.rankName
        title.position = CGPointMake(CGRectGetMidX(myFrame), myFrame.maxY - 60)
        title.zPosition = 5
        addChild(title)
        
        // display score
        let lineHeight: CGFloat = 35
        var line: Int = 1
        let baseY: CGFloat = 75
        for i in rank!.ranks {
            var c: UIColor = line == rank!.lastPos ? SKColor.redColor() : SKColor.whiteColor()
            let sc: ScoreCard = i as ScoreCard
            let labelPos = SKLabelNode()
            labelPos.text = toString(line)
            labelPos.fontSize = 34
            labelPos.fontColor = c
            labelPos.position = CGPointMake(myFrame.minX + 40.0, myFrame.maxY - lineHeight * CGFloat(line) - baseY)
            labelPos.zPosition = 5
            addChild(labelPos)
            let labelScore = SKLabelNode()
            labelScore.text = String(format: "%5.1f", sc.score)
            labelScore.fontSize = 34
            labelScore.fontColor = c
            labelScore.position = CGPointMake(myFrame.minX + 110.0, myFrame.maxY - lineHeight * CGFloat(line) - baseY)
            labelScore.zPosition = 5
            addChild(labelScore)
            let df: NSDateFormatter = NSDateFormatter()
            df.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let labelTime = SKLabelNode()
            labelTime.text = df.stringFromDate(sc.time)
            labelTime.fontSize = 34
            labelTime.fontColor = c
            labelTime.position = CGPointMake(myFrame.minX + 400.0, myFrame.maxY - lineHeight * CGFloat(line) - baseY)
            labelTime.zPosition = 5
            addChild(labelTime)
            line++
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for touch in touches {
            let location = touch.locationInNode(self)
            var touchedNode = nodeAtPoint(location)
            if touchedNode.name == "clear" {
                rank!.clear()
                rankMng.saveData()
                removeFromParent()
            }
            else if touchedNode.name == "exec" {
                (parent as Welcome).runExec()
            }
            else if touchedNode.name == "test" {
                (parent as Welcome).runTest()
            }
            else {
                removeFromParent()
            }
        }
    }
}