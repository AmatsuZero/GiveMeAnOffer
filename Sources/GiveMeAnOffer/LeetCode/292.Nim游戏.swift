//
//  292.Nim游戏.swift
//  GiveMeAnOffer
//
//  Created by 姜振华 on 2019/6/24.
//

/*
 https://zhuanlan.zhihu.com/p/37447851
 你和你的朋友，两个人一起玩Nim游戏：桌子上有一堆石头，每次你们轮流拿掉 1 - 3 块石头。
 拿掉最后一块石头的人就是获胜者。
 你作为先手。你们是聪明人，每一步都是最优解。
 编写一个函数，来判断你是否可以在给定石头数量的情况下赢得游戏。
 
 示例:
 输入: 4
 
 输出: false
 
 解释: 如果堆中有 4 块石头，那么你永远不会赢得比赛；
 
 因为无论你拿走 1块、2块 还是 3块石头，最后一块石头总是会被你的朋友拿走。
 
 
 根据题目的提示，很容易得到一点思路。可以说，只要玩家某一方面对的是4块石头，那就输了。所以要想赢得比赛，就是要让对方面对4块石头。
 所以当自己面对的是5/6/7块石头的时候，就赢了。
 （拿走1/2/3块石头就让对方面对4块石头的必输情况）那如果我们面对的有8块石头呢？这时候，无论我们怎么拿，都会让对方面对5/6/7块石头的必赢情况，所以到这里，我们可以尝试答题了。
 */
import Foundation

public extension Int {
    
    var canWinNim: Bool {
        return self % 4 != 0
    }
}
