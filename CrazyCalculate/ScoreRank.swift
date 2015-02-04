//
//  ScoreRank.swift
//  CrazyCalculate
//
//  Created by bobo on 14/11/16.
//  Copyright (c) 2014年 Xiong Bo. All rights reserved.
//

import Foundation

class ScoreRank: NSObject, NSCoding {

    var ranks: NSMutableArray
    var lastPos: Int
    var rankName: String
    
    required init(coder aDecoder: NSCoder) {
        ranks = aDecoder.decodeObjectForKey("ranks") as NSMutableArray
        lastPos = aDecoder.decodeIntegerForKey("lastPos")
        rankName = aDecoder.decodeObjectForKey("rankName") as String
    }

    init(rankName: String) {
        ranks = NSMutableArray()
        self.rankName = rankName
        lastPos = 0
    }

    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(ranks, forKey: "ranks")
        aCoder.encodeInteger(lastPos, forKey: "lastPos")
        aCoder.encodeObject(rankName, forKey: "rankName")
    }

    func addScore(score: ScoreCard) -> Bool {
        lastPos = 0
        
        var index: Int = 0
        var isInsert: Bool = false
        for i in ranks {
            if score.score < i.score {
                ranks.insertObject(score, atIndex: index)
                lastPos = index + 1
                isInsert = true
                break
            }
            if ++index > 10 {
                break
            }
        }
        if !isInsert && index < 10 {
            ranks.addObject(score)
            lastPos = index + 1
            isInsert = true
        }
        
        while ranks.count > 10 {
            ranks.removeLastObject()
        }
        
        return isInsert
    }
    
    func clear() {
        ranks.removeAllObjects()
    }

    func description() -> String {
        var ret: String = ""
        var index: Int = 0
        for score in ranks {
            index++
            ret += "rank: \(index), Name: \((score as ScoreCard).userName), time: \((score as ScoreCard).time), score: \((score as ScoreCard).score) \r\n"
        }
        return ret
    }
}