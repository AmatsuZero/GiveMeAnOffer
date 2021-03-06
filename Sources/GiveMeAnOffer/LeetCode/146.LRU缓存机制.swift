//
// Created by daubert on 2019/8/7.
//
/*
 * @lc app=leetcode.cn id=146 lang=swift
 *
 * [146] LRU缓存机制
 *
 * https://leetcode-cn.com/problems/lru-cache/description/
 *
 * algorithms
 * Medium (42.29%)
 * Likes:    198
 * Dislikes: 0
 * Total Accepted:    13K
 * Total Submissions: 30.7K
 * Testcase Example:  '["LRUCache","put","put","get","put","get","put","get","get","get"]\n' +
  '[[2],[1,1],[2,2],[1],[3,3],[2],[4,4],[1],[3],[4]]'
 *
 * 运用你所掌握的数据结构，设计和实现一个  LRU (最近最少使用) 缓存机制。它应该支持以下操作： 获取数据 get 和 写入数据 put 。
 *
 * 获取数据 get(key) - 如果密钥 (key) 存在于缓存中，则获取密钥的值（总是正数），否则返回 -1。
 * 写入数据 put(key, value) -
 * 如果密钥不存在，则写入其数据值。当缓存容量达到上限时，它应该在写入新数据之前删除最近最少使用的数据值，从而为新的数据值留出空间。
 *
 * 进阶:
 *
 * 你是否可以在 O(1) 时间复杂度内完成这两种操作？
 *
 * 示例:
 *
 * LRUCache cache = new LRUCache( 2 /* 缓存容量 */ );
 *
 * cache.put(1, 1);
 * cache.put(2, 2);
 * cache.get(1);       // 返回  1
 * cache.put(3, 3);    // 该操作会使得密钥 2 作废
 * cache.get(2);       // 返回 -1 (未找到)
 * cache.put(4, 4);    // 该操作会使得密钥 1 作废
 * cache.get(1);       // 返回 -1 (未找到)
 * cache.get(3);       // 返回  3
 * cache.get(4);       // 返回  4
 *
 *
 */
import Foundation

public class LRUCache<Key: Hashable, Value> {

    private(set) var size: Int
    private(set) var num = 0
    private(set) var allKeys = [Key]()
    private var keysAndValues = [Key: Value]()

    public init(capacity: Int) {
        self.size = capacity
    }

    public func put(_ key: Key, _ value: Value) {
        if keysAndValues[key] != nil {
            if let index = allKeys.firstIndex(of: key) {
                allKeys.remove(at: index)
            }
            keysAndValues[key] = value
            allKeys.append(key)
        } else {
            if num == size {
                if let k = allKeys.first {
                    keysAndValues.removeValue(forKey: k)
                    allKeys.remove(at: 0)
                    keysAndValues[key] = value
                    allKeys.append(key)
                }
            } else {
                keysAndValues[key] = value
                allKeys.append(key)
                num += 1
            }
        }
    }

     public func get(_ key: Key) -> Value? {
        guard keysAndValues[key] != nil else {
            return nil
        }
        if let index = allKeys.firstIndex(of: key) {
            allKeys.remove(at: index)
        }
        allKeys.append(key)
        return keysAndValues[key]
    }

    public subscript(_ key: Key) -> Value? {
        get {
            return self.get(key)
        }
        set {
            guard let value = newValue else {
                return
            }
            self.put(key, value)
        }
    }
}