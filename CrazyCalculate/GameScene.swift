//
//  GameScene.swift
//  CrazyCalculate
//
//  Created by bobo on 14/11/1.
//  Copyright (c) 2014年 Xiong Bo. All rights reserved.
//

import SpriteKit
import AVFoundation

enum CalcOp: Int {
    case
        AddOp = 0,       // = 0
        SubOp,            //
        MulOp,
        DivOp
}

enum CalcMode: Int {
    case
        ExerMode = 0,
        TestMode = 1
    
}

enum NumMode: Int {
    case
        Less10Mode = 0,
        Less20Mode = 1,
        Less20_1Mode = 2,
        Less30Mode = 3
}

protocol CalcInterface {
    func clearNum()
    func inputNum(num: Int)
    func acceptAnswer()
}

class GameScene: SKScene, CalcInterface {
    
    var val1: Array<Int> = Array<Int>()
    var val2: Array<Int> = Array<Int>()
    var op: Array<CalcOp> = Array<CalcOp>()
    var result: Array<Int> = Array<Int>()
    var answer: Array<Int> = Array<Int>()
    var curIndex: Int = 0
    var count: Int = 0
    var rightCount: Int = 0
    var wrongCount: Int = 0
    var calcMode: CalcMode
    var numMode: NumMode
    var calcOp: CalcOp
    var wait: Bool
    var startTime: NSDate
    var lastTime: NSDate
    var elapse: Float
    var displayIndex: Int = 0
    var displayCount: Int = 0
    
    var usedTimeLabel: SKLabelNode
    var curLabel: SKLabelNode
    var thumbBar: ThumbBar
    
    var rightAudio: AVAudioPlayer?
    var wrongAudio: AVAudioPlayer?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(size: CGSize, calcMode: CalcMode, numMode: NumMode, calcOp: CalcOp) {

        srandom(UInt32(time(nil)))
        
        thumbBar = ThumbBar(frame: CGRectMake((size.width - 200) / 2, size.height - 40, 200, 30))

        usedTimeLabel = SKLabelNode(fontNamed: "OpenSans-Bold")
        usedTimeLabel.position = CGPointMake(size.width / 2, 730)
        usedTimeLabel.fontColor = SKColor.whiteColor()
        usedTimeLabel.fontSize = 32
        usedTimeLabel.text = ""
        usedTimeLabel.zPosition = 2

        curLabel = SKLabelNode(fontNamed:"Chalkduster")
        curLabel.text = "";
        curLabel.fontSize = 100;
        curLabel.fontColor = SKColor.whiteColor()
        curLabel.position = CGPoint(x: size.width / 2, y: size.height / 2 + 200)
        curLabel.zPosition = 2

        let rightUrl = NSURL(fileURLWithPath:NSBundle.mainBundle().pathForResource("clank", ofType:"wav")!)
        rightAudio = AVAudioPlayer(contentsOfURL:rightUrl, error:nil)
        let wrongUrl = NSURL(fileURLWithPath:NSBundle.mainBundle().pathForResource("beepwrong", ofType:"mp3")!)
        wrongAudio = AVAudioPlayer(contentsOfURL:wrongUrl, error:nil)

        curIndex = 0
        count = 0
        wait = false
        self.calcMode = calcMode
        self.numMode = numMode
        self.calcOp = calcOp
        startTime = NSDate()
        lastTime = startTime
        elapse = 0.0
        displayIndex = 0
        displayCount = 0

        super.init(size: size)

        let bg = SKSpriteNode(imageNamed: "bg.png")
        bg.size = CGSizeMake(1024, 768)
        bg.position = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame))
        bg.zPosition = 0
        addChild(bg)

        addChild(usedTimeLabel)
        addChild(curLabel)
        addChild(thumbBar)
    }

    override func didMoveToView(view: SKView) {
        scaleMode = .AspectFill
        restart()
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        for touch in touches {
            let location = touch.locationInNode(self)
            var touchedNode = nodeAtPoint(location)
            if touchedNode.name == "restart" {
                removeChildrenInArray([touchedNode, childNodeWithName("back")!, childNodeWithName("result")!])
                restart()
            }
            else if touchedNode.name == "back" {
                let scene = Welcome.init(size: self.size)
                view!.presentScene(scene)
            }
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        if curIndex < count {
            let now = NSDate()
            let diff = now.timeIntervalSinceDate(lastTime)
            if diff > 0.2 || curIndex != displayIndex || count != displayCount {
                displayIndex = curIndex
                displayCount = count
                elapse = Float(now.timeIntervalSinceDate(startTime))
                usedTimeLabel.text = String(format: "(%d/%d)%.1f", curIndex, count, elapse)
                usedTimeLabel.zPosition = 2
                lastTime = now
            }
        }
    }
    
    func restartAddLess10Mode() {
        count = 0
        for i in 1 ... 9 {
            for j in 1 ... 9 {
                if i + j <= 10 {
                    val1.append(i)
                    val2.append(j)
                    op.append(.AddOp)
                    answer.append(i+j)
                    result.append(-1)
                    count++
                }
            }
        }
        shuffle()
    }

    func restartAddLess20Mode() {
        count = 0
        for i in 1 ... 9 {
            for j in 1 ... 9 {
                if i + j <= 20 && i + j > 10 {
                    val1.append(i)
                    val2.append(j)
                    op.append(.AddOp)
                    answer.append(i+j)
                    result.append(-1)
                    count++
                }
            }
        }
        shuffle()
        // count == 36
    }
    
    
    func restartAddLess20_1Mode() {
        count = 0
        for i in 10 ... 19 {
            for j in 1 ... 10 {
                if i + j <= 20 {
                    val1.append(i)
                    val2.append(j)
                    op.append(.AddOp)
                    answer.append(i+j)
                    result.append(-1)
                    count++
                }
            }
        }
        shuffle()
        // count == 55
    }

    func restartSubLess10Mode() {
        count = 0
        for i in 2 ... 9 {
            for j in 1 ... i - 1 {
                val1.append(i)
                val2.append(j)
                op.append(.SubOp)
                answer.append(i-j)
                result.append(-1)
                count++
            }
        }
        shuffle()
    }

    func restartSubLess20Mode() {
        count = 0
        for i in 11 ... 19 {
            for j in 10 ... i - 1 {
                val1.append(i)
                val2.append(j)
                op.append(.SubOp)
                answer.append(i-j)
                result.append(-1)
                count++
            }
        }
        shuffle()
    }

    func restartSubLess20_1Mode() {
        count = 0
        for i in 11 ... 19 {
            for j in 5 ... 9 {
                val1.append(i)
                val2.append(j)
                op.append(.SubOp)
                answer.append(i-j)
                result.append(-1)
                count++
            }
        }
        shuffle()
    }
    
    func restartAddLess30Mode() {
        count = 0
        for i in 11 ... 19 {
            for j in i ... 19 {
                val1.append(i)
                val2.append(j)
                op.append(.AddOp)
                answer.append(i+j)
                result.append(-1)
                count++
            }
        }
        shuffle()
    }
    
    func restartSubLess30Mode() {
        count = 0
        for i in 20 ... 30 {
            for j in 15 ... 25 {
                if i - j > 6 {
                    val1.append(i)
                    val2.append(j)
                    op.append(.SubOp)
                    answer.append(i-j)
                    result.append(-1)
                    count++
                }
            }
        }
        shuffle()
    }

    func shuffle() {
        for i in 1 ... count / 2 {
            let pos1: Int = random() % count
            let pos2: Int = random() % count
            if pos1 != pos2 {
                swapItem(pos1, b: pos2)
            }
        }
        
        var isSwap = true
        while isSwap {
            isSwap = false
            for i in 2 ... count - 1 {
                if (val1[i] == val2[i-1]) && (val2[i] == val1[i-1]) {
                    let pos1 = random() % count
                    swapItem(i, b: pos1)
                    isSwap = true
                }
            }
        }
    }

    func swapItem(a: Int, b: Int) {
        (val1[a], val1[b]) = (val1[b], val1[a])
        (val2[a], val2[b]) = (val2[b], val2[a])
        (answer[a], answer[b]) = (answer[b], answer[a])
    }

    func restart() {

        if val1.count != 0 {
            val1.removeAll(keepCapacity: true)
            val2.removeAll(keepCapacity: true)
            op.removeAll(keepCapacity: true)
            answer.removeAll(keepCapacity: true)
            result.removeAll(keepCapacity: true)
        }
        
        if (calcOp == .AddOp) && (numMode == .Less10Mode) {
            restartAddLess10Mode()
        }
        else if (calcOp == .SubOp) && (numMode == .Less10Mode) {
            restartSubLess10Mode()
        }
        else if (calcOp == .MulOp) && (numMode == .Less10Mode) {
            
        }
        else if (calcOp == .DivOp) && (numMode == .Less10Mode) {
            
        }
        else if (calcOp == .AddOp) && (numMode == .Less20Mode) {
            restartAddLess20Mode()
        }
        else if (calcOp == .SubOp) && (numMode == .Less20Mode) {
            restartSubLess20Mode()
        }
        else if (calcOp == .MulOp) && (numMode == .Less20Mode) {
            
        }
        else if (calcOp == .DivOp) && (numMode == .Less20Mode) {
            
        }
        else if (calcOp == .AddOp) && (numMode == .Less20_1Mode) {
            restartAddLess20_1Mode()
        }
        else if (calcOp == .SubOp) && (numMode == .Less20_1Mode) {
            restartSubLess20_1Mode()
        }
        else if (calcOp == .MulOp) && (numMode == .Less20_1Mode) {
            
        }
        else if (calcOp == .DivOp) && (numMode == .Less20_1Mode) {
            
        }
        else if (calcOp == .AddOp) && (numMode == .Less30Mode) {
            restartAddLess30Mode()
        }
        else if (calcOp == .SubOp) && (numMode == .Less30Mode) {
            restartSubLess30Mode()
        }
        else {
            restartAddLess10Mode()
        }
        
        curIndex = 0
        startTime = NSDate()
        lastTime = startTime
        rightCount = 0
        wrongCount = 0
        displayCount = 0
        displayIndex = 0
        
        if childNodeWithName("keyboard") == nil {
            let f = CGRectMake(0, 0, 1024, 768)
            let keyboard = Keyboard(frame: f, calc: self)
            keyboard.position = CGPoint(x: 100, y: 20);
            keyboard.name = "keyboard"
            keyboard.zPosition = 1
            addChild(keyboard)
        }
        
        thumbBar.clear()
        thumbBar.setCount(count)
        
        displayCurrent(curLabel)
    }
    
    func acceptAnswer() {
        if curIndex >= count || wait {
            return
        }
        
        if result[curIndex] == (answer[curIndex]) {
            wait = true
            // play right sound
            rightAudio?.play()
            
            curLabel.fontColor = SKColor.greenColor()
            let rightAction1 = SKAction.scaleTo(1.1, duration: 0.1)
            let rightAction2 = SKAction.scaleTo(1.0, duration: 0.1)
            let rightAction3 = SKAction.waitForDuration(0.2)
            curLabel.runAction(SKAction.sequence([rightAction1, rightAction2, rightAction3])) {
                self.curLabel.fontColor = SKColor.whiteColor()
                self.curIndex++
                self.rightCount++
                self.displayCurrent(self.curLabel)
                self.thumbBar.addResult(.TBColor1)
                self.wait = false
            }
        }
        else if calcMode == .TestMode && answer[curIndex] > 9 && result[curIndex] <= 9 {
            //return
        }
        else {
            wait = true
            // play error sound
            wrongAudio?.play()
            
            curLabel.fontColor = SKColor.redColor()
            let wrongAction1 = SKAction.moveByX(-10, y: 0, duration: 0.09)
            let wrongAction2 = SKAction.moveByX(20, y: 0, duration: 0.09)
            let wrongAction3 = SKAction.moveByX(-20, y: 0, duration: 0.09)
            let wrongAction4 = SKAction.moveByX(10, y: 0, duration: 0.09)
            let wrongAction5 = SKAction.waitForDuration(0.2)
            curLabel.runAction(SKAction.sequence([wrongAction1, wrongAction2, wrongAction3, wrongAction4, wrongAction5])) {
                self.curLabel.fontColor = SKColor.whiteColor()
                self.curIndex++
                self.wrongCount++
                self.displayCurrent(self.curLabel)
                self.thumbBar.addResult(.TBColor2)
                self.wait = false
            }
        }
        
        displayCurrent(curLabel)
    }

    func clearNum() {
        if curIndex >= count || wait {
            return
        }
        
        result[curIndex] = result[curIndex] / 10
        
        if result[curIndex] == 0 {
            result[curIndex] = -1
        }
        
        displayCurrent(curLabel)
    }
    
    func inputNum(num: Int) {
        if curIndex >= count || wait {
            return
        }
        
        if result[curIndex] != -1 {
            result[curIndex] = result[curIndex] * 10 + num;
        }
        else {
            result[curIndex] = num;
        }
        
        if calcMode == .TestMode {
            acceptAnswer()
        }
        else {
            displayCurrent(curLabel)
        }
    }
    
    func displayCurrent(label: SKLabelNode) {
        if curIndex >= count {
        //if curIndex == 1  {
            removeChildrenInArray([childNodeWithName("keyboard")!])
            
            label.text = ""

            let result = SKLabelNode(fontNamed: "OpenSans-Bold")
            result.position = CGPoint(x:size.width / 2, y:450)
            result.fontColor = SKColor.whiteColor()
            result.fontSize = 100
            result.text = String(format: "正确%d题，错误%d题", rightCount, wrongCount)
            result.name = "result"
            result.zPosition = 2
            addChild(result)
            usedTimeLabel.text = String(format: "(%d/%d)%.1f", curIndex, count, elapse)
            
            if wrongCount == 0 {
                var score: ScoreCard = ScoreCard()
                score.score = elapse
                if rankMng.addScore(score, calcOp: calcOp, numMode: numMode) {
                    rankMng.saveData()
                    
                    let sb: ScoreBoard = ScoreBoard(frame: CGRectMake(200, 100, 600, 500), opMode: calcOp, numMode: numMode, showButton: 0)
                    addChild(sb)
                }
            }
            
            // restart
            let restart = SKLabelNode(fontNamed: "OpenSans-Bold")
            restart.position = CGPoint(x:300, y:300)
            restart.fontColor = SKColor.whiteColor()
            restart.fontSize = 70
            restart.text = "再来一次"
            restart.name = "restart"
            restart.zPosition = 2
            addChild(restart)
            
            let back = SKLabelNode(fontNamed: "OpenSans-Bold")
            back.position = CGPoint(x:750, y:300)
            back.fontColor = SKColor.whiteColor()
            back.fontSize = 70
            back.text = "返回首页"
            back.name = "back"
            back.zPosition = 2
            addChild(back)
            
        }
        else {
            var opSign: String = "+"
            if calcOp == .AddOp {
                opSign = "+"
            }
            else if calcOp == .SubOp {
                opSign = "-"
            }
            label.text = toString(val1[curIndex]) + opSign + toString(val2[curIndex]) + "="
            if result[curIndex] != -1 {
                label.text += toString(result[curIndex])
            }
        }
    }
    
}
