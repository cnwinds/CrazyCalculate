//
//  TopScore.swift
//  CrazyCalculate
//
//  Created by bobo on 14/11/16.
//  Copyright (c) 2014年 Xiong Bo. All rights reserved.
//

import Foundation

class ScoreCard: NSObject, NSCoding {
    var userName: String
    var time: NSDate
    var score: Float
    
    required init(coder aDecoder: NSCoder) {
        userName = aDecoder.decodeObjectForKey("userName") as String
        time = aDecoder.decodeObjectForKey("time") as NSDate
        score = aDecoder.decodeFloatForKey("score")
    }
    
    init(userName: String = "", time: NSDate = NSDate(), score: Float = 0.0) {
        self.userName = userName
        self.time = time
        self.score = score
    }

    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(userName, forKey: "userName")
        aCoder.encodeObject(time, forKey: "time")
        aCoder.encodeFloat(score, forKey: "score")
    }
}