//
//  48.旋转图像.swift
//  GiveMeAnOffer
//
//  Created by 姜振华 on 2019/7/7.
//

/*
 给定一个 n × n 的二维矩阵表示一个图像。
 
 将图像顺时针旋转 90 度。
 
 说明：
 
 你必须在原地旋转图像，这意味着你需要直接修改输入的二维矩阵。请不要使用另一个矩阵来旋转图像。
 
 示例 1:
 
 给定 matrix =
 [
 [1,2,3],
 [4,5,6],
 [7,8,9]
 ],
 
 原地旋转输入矩阵，使其变为:
 [
 [7,4,1],
 [8,5,2],
 [9,6,3]
 ]
 示例 2:
 
 给定 matrix =
 [
 [ 5, 1, 9,11],
 [ 2, 4, 8,10],
 [13, 3, 6, 7],
 [15,14,12,16]
 ],
 
 原地旋转输入矩阵，使其变为:
 [
 [15,13, 2, 5],
 [14, 3, 4, 1],
 [12, 6, 8, 9],
 [16, 7,10,11]
 ]
 */
import Foundation

// https://www.jianshu.com/p/47435d902635

public extension Array where Element == [Int] {
    
    mutating func rotate() {
        guard self.count > 1 else {
            return
        }
        
        let n = self.count
        //旋转次数
        let count = n * n / 4
        
        var x = 0, y = 0, z = 0, x1 = 0, y1 = 0, x2 = 0, y2 = 0
        for _ in 0..<count {
            if z >= n - 1 - 2 * x {
                x += 1
                z = 0
            }
            
            y = z + x
            z += 1
            
            x1 = x
            y1 = y
            
            for _ in 0..<3 {
                x2 = n - 1 - y1
                y2 = x1
                
                self[x1][y1] ^= self[x2][y2]
                self[x2][y2] ^= self[x1][y1]
                self[x1][y1] ^= self[x2][y2]
                
                x1 = x2
                y1 = y2
            }
        }
    }
}
