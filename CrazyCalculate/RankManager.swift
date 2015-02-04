//
//  RankManager.swift
//  CrazyCalculate
//
//  Created by bobo on 14/11/18.
//  Copyright (c) 2014年 Xiong Bo. All rights reserved.
//

import Foundation

class RankManager {

    var add10Rank: ScoreRank
    var add20Rank: ScoreRank
    var add20_1Rank: ScoreRank
    var add30Rank: ScoreRank
    var sub10Rank: ScoreRank
    var sub20Rank: ScoreRank
    var sub20_1Rank: ScoreRank
    var sub30Rank: ScoreRank
    var rootPath: String
    
    init() {
        add10Rank = ScoreRank(rankName: "10以内加法")
        add20Rank = ScoreRank(rankName: "20以内加法")
        add20_1Rank = ScoreRank(rankName: "20_1以内加法")
        add30Rank = ScoreRank(rankName: "30以内加法")
        sub10Rank = ScoreRank(rankName: "10以内减法")
        sub20Rank = ScoreRank(rankName: "20以内减法")
        sub20_1Rank = ScoreRank(rankName: "20_1以内减法")
        sub30Rank = ScoreRank(rankName: "30以内减法")
        
        var paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        rootPath = paths[0] as String
        
        loadData()
    }
    
    func loadData() {
        var sr1: ScoreRank? = NSKeyedUnarchiver.unarchiveObjectWithFile(rootPath + "/add10Rank.rank") as? ScoreRank
        if sr1 != nil && sr1?.rankName == "10以内加法" {
            add10Rank = sr1!
        }
        var sr2: ScoreRank? = NSKeyedUnarchiver.unarchiveObjectWithFile(rootPath + "/add20Rank.rank") as? ScoreRank
        if sr2 != nil && sr2?.rankName == "20以内加法" {
            add20Rank = sr2!
        }
        var sr2_1: ScoreRank? = NSKeyedUnarchiver.unarchiveObjectWithFile(rootPath + "/add20_1Rank.rank") as? ScoreRank
        if sr2_1 != nil && sr2_1?.rankName == "20_1以内加法" {
            add20_1Rank = sr2_1!
        }
        var sr30_add: ScoreRank? = NSKeyedUnarchiver.unarchiveObjectWithFile(rootPath + "/add30Rank.rank") as? ScoreRank
        if sr30_add != nil && sr30_add?.rankName == "30以内加法" {
            add30Rank = sr30_add!
        }
        var sr3: ScoreRank? = NSKeyedUnarchiver.unarchiveObjectWithFile(rootPath + "/sub10Rank.rank") as? ScoreRank
        if sr3 != nil && sr3?.rankName == "10以内减法" {
            sub10Rank = sr3!
        }
        var sr4: ScoreRank? = NSKeyedUnarchiver.unarchiveObjectWithFile(rootPath + "/sub20Rank.rank") as? ScoreRank
        if sr4 != nil && sr4?.rankName == "20以内减法" {
            sub20Rank = sr4!
        }
        var sr4_1: ScoreRank? = NSKeyedUnarchiver.unarchiveObjectWithFile(rootPath + "/sub20_1Rank.rank") as? ScoreRank
        if sr4_1 != nil && sr4_1?.rankName == "20_1以内减法" {
            sub20_1Rank = sr4_1!
        }
        var sr30_sub: ScoreRank? = NSKeyedUnarchiver.unarchiveObjectWithFile(rootPath + "/sub30Rank.rank") as? ScoreRank
        if sr30_sub != nil && sr30_sub?.rankName == "30以内减法" {
            sub30Rank = sr30_sub!
        }
    }
    
    func saveData() {
        NSKeyedArchiver.archiveRootObject(add10Rank, toFile: rootPath + "/add10Rank.rank")
        NSKeyedArchiver.archiveRootObject(add20Rank, toFile: rootPath + "/add20Rank.rank")
        NSKeyedArchiver.archiveRootObject(add20_1Rank, toFile: rootPath + "/add20_1Rank.rank")
        NSKeyedArchiver.archiveRootObject(add30Rank, toFile: rootPath + "/add30Rank.rank")
        NSKeyedArchiver.archiveRootObject(sub10Rank, toFile: rootPath + "/sub10Rank.rank")
        NSKeyedArchiver.archiveRootObject(sub20Rank, toFile: rootPath + "/sub20Rank.rank")
        NSKeyedArchiver.archiveRootObject(sub20_1Rank, toFile: rootPath + "/sub20_1Rank.rank")
        NSKeyedArchiver.archiveRootObject(sub30Rank, toFile: rootPath + "/sub30Rank.rank")
    }
    
    func addScore(scoreCard: ScoreCard, calcOp: CalcOp, numMode: NumMode) -> Bool {
        if calcOp == .AddOp && numMode == .Less10Mode {
            return add10Rank.addScore(scoreCard)
        }
        else if calcOp == .AddOp && numMode == .Less20Mode {
            return add20Rank.addScore(scoreCard)
        }
        else if calcOp == .AddOp && numMode == .Less20_1Mode {
            return add20_1Rank.addScore(scoreCard)
        }
        else if calcOp == .AddOp && numMode == .Less30Mode {
            return add30Rank.addScore(scoreCard)
        }
        else if calcOp == .SubOp && numMode == .Less10Mode {
            return sub10Rank.addScore(scoreCard)
        }
        else if calcOp == .SubOp && numMode == .Less20Mode {
            return sub20Rank.addScore(scoreCard)
        }
        else if calcOp == .SubOp && numMode == .Less20_1Mode {
            return sub20_1Rank.addScore(scoreCard)
        }
        else if calcOp == .SubOp && numMode == .Less30Mode {
            return sub30Rank.addScore(scoreCard)
        }
        return false
    }
    
    func getRank(calcOp: CalcOp, numMode: NumMode) -> ScoreRank? {
        if calcOp == .AddOp && numMode == .Less10Mode {
            return add10Rank
        }
        else if calcOp == .AddOp && numMode == .Less20Mode {
            return add20Rank
        }
        else if calcOp == .AddOp && numMode == .Less20_1Mode {
            return add20_1Rank
        }
        else if calcOp == .AddOp && numMode == .Less30Mode {
            return add30Rank
        }
        else if calcOp == .SubOp && numMode == .Less10Mode {
            return sub10Rank
        }
        else if calcOp == .SubOp && numMode == .Less20Mode {
            return sub20Rank
        }
        else if calcOp == .SubOp && numMode == .Less20_1Mode {
            return sub20_1Rank
        }
        else if calcOp == .SubOp && numMode == .Less30Mode {
            return sub30Rank
        }
        return nil
    }
}

let rankMng: RankManager = RankManager()