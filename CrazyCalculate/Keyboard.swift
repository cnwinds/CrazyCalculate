//
//  Keyboard.swift
//  CrazyCalculate
//
//  Created by bobo on 14/11/2.
//  Copyright (c) 2014年 Xiong Bo. All rights reserved.
//

import Foundation
import SpriteKit

class Keyboard : SKNode {

    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    let calc: CalcInterface
    let kbTexutre: SKTexture
    let kbSize: CGSize
    var btnX: [CGFloat] = [50, 250, 450, 50, 250, 450, 50, 250, 450, 50, 250, 450]
    var btnY: [CGFloat] = [10, 10, 10, 85, 85, 85, 160, 160, 160, 235, 235, 235]
    var btnText: [String] = ["C", "0", "=", "7", "8", "9", "4", "5", "6", "1", "2", "3"];
    let btnSize: CGSize
    let btnGap: CGFloat
    var touchedButton: SKNode? = nil

    init(frame: CGRect, calc: CalcInterface) {
        kbTexutre = SKTexture(imageNamed: "button.png")
        kbSize = CGSizeMake(frame.width, frame.height)
        btnGap = 14
        btnSize = CGSizeMake(500 / 3 - btnGap, 400 / 4 - btnGap)
        self.calc = calc
        super.init()

        for i in 0 ... 11 {
            let line = i / 3
            let col = i % 3
            btnX[i] = frame.width * 0.23 + CGFloat(col) * (btnSize.width + btnGap)
            btnY[i] = frame.height * 0.1 + CGFloat(line) * (btnSize.height + btnGap)
            newOneKey(i)
        }

        userInteractionEnabled = true
    }
    
    func newOneKey(index: Int) {
        
        if index > btnX.count {
            return
        }
        
        let keySize = CGSizeMake(btnSize.width, btnSize.height)
        let bkNode = SKSpriteNode(texture: kbTexutre, color: nil, size: keySize)
        bkNode.position = CGPointMake(btnX[index], btnY[index])
        bkNode.name = btnText[index]
        addChild(bkNode)

        let numNode = SKLabelNode(fontNamed: "OpenSans-Bold")
        numNode.fontSize = 30
        numNode.fontColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        numNode.text = btnText[index]
        numNode.position = CGPointMake(0, -10)
        bkNode.addChild(numNode)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        if touchedButton != nil {
            return
        }
        
        for touch in touches {
            let location = touch.locationInNode(self)
            var touchedNode = nodeAtPoint(location) as SKNode
            
            if touchedNode.name == nil {
                touchedNode = touchedNode.parent!
            }
            
            let val = touchedNode.name
            if val == nil {
                // nothing
            }
            else if val == "C" {
                calc.clearNum()
                touchedButton = touchedNode
            }
            else if val == "=" {
                calc.acceptAnswer()
                touchedButton = touchedNode
            }
            else if val?.toInt() != nil {
                calc.inputNum(val!.toInt()!)
                touchedButton = touchedNode
            }
            
            if touchedButton != nil {
                touchedButton!.runAction(SKAction.scaleTo(1.5, duration: 0.1))
                break
            }
        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        if touchedButton != nil {
            touchedButton!.runAction(SKAction.scaleTo(1, duration: 0.1))
            touchedButton = nil
        }
    }
}