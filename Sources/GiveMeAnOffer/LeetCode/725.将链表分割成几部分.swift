//
// Created by daubert on 2019/8/4.
//
/*
/*
 * @lc app=leetcode.cn id=725 lang=swift
 *
 * [725] 分隔链表
 *
 * https://leetcode-cn.com/problems/split-linked-list-in-parts/description/
 *
 * algorithms
 * Medium (48.38%)
 * Likes:    26
 * Dislikes: 0
 * Total Accepted:    2.5K
 * Total Submissions: 5K
 * Testcase Example:  '[1,2,3,4]\n5'
 *
 * 给定一个头结点为 root 的链表, 编写一个函数以将链表分隔为 k 个连续的部分。
 *
 * 每部分的长度应该尽可能的相等: 任意两部分的长度差距不能超过 1，也就是说可能有些部分为 null。
 *
 * 这k个部分应该按照在链表中出现的顺序进行输出，并且排在前面的部分的长度应该大于或等于后面的长度。
 *
 * 返回一个符合上述规则的链表的列表。
 *
 * 举例： 1->2->3->4, k = 5 // 5 结果 [ [1], [2], [3], [4], null ]
 *
 * 示例 1：
 *
 *
 * 输入:
 * root = [1, 2, 3], k = 5
 * 输出: [[1],[2],[3],[],[]]
 * 解释:
 * 输入输出各部分都应该是链表，而不是数组。
 * 例如, 输入的结点 root 的 val= 1, root.next.val = 2, \root.next.next.val = 3, 且
 * root.next.next.next = null。
 * 第一个输出 output[0] 是 output[0].val = 1, output[0].next = null。
 * 最后一个元素 output[4] 为 null, 它代表了最后一个部分为空链表。
 *
 *
 * 示例 2：
 *
 *
 * 输入:
 * root = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], k = 3
 * 输出: [[1, 2, 3, 4], [5, 6, 7], [8, 9, 10]]
 * 解释:
 * 输入被分成了几个连续的部分，并且每部分的长度相差不超过1.前面部分的长度大于等于后面部分的长度。
 *
 *
 *
 *
 * 提示:
 *
 *
 * root 的长度范围： [0, 1000].
 * 输入的每个节点的大小范围：[0, 999].
 * k 的取值范围： [1, 50].
 *
 *
 *
 *
 */
*/
import Foundation

/*
首先要统计链表中结点的总个数，然后除以k，得到的商就是能分成的部分个数，余数就是包含有多余的结点的子链表的个数。我们开始for循环，循环的结束条件是i小于k且root存在，要生成k个子链表，在循环中，先把头结点加入结果res中对应的位置，然后就要遍历该子链表的结点个数了，
首先每个子链表都一定包含有avg个结点，这是之前除法得到的商，然后还要有没有多余结点，如果i小于ext，就说明当前子链表还得有一个多余结点，然后我们将指针向后移动一个，注意我们这里的j是从1开始，我们希望移动到子链表的最后一个结点上，而不是移动到下一个子链表的首结点，因为我们要断开链表。我们新建一个临时结点t指向下一个结点，也就是下一个子链表的首结点，然后将链表断开，再将root指向临时结点t，这样就完成了断开链表的操作。

*/
extension ListNode {

    public func split(by k: Int) -> [ListNode?] {
        var result = [ListNode?](repeating: nil, count: k)
        var count = 0
        var index: ListNode? = self
        while index != nil {
            count += 1
            index = index?.next
        }

        let average = count / k // 平均的
        let remaining = count % k // 剩余的
        index = self
        var head = index // 每一段的头
        for i in 0..<k {
            var total = i < remaining ? average + 1 : average
            total -= 1
            if total > 0 {
                for _ in 0..<total {
                    if let node = index?.next {
                        index = node
                    }
                }
            }
            result[i] = head
            if let last = index {
                index = index?.next
                head = index
                last.next = nil
            } else {
                head = nil
            }
        }

        return result
    }
}