//
//  CalculatorModel.swift
//  Calculator
//
//  Created by chenbing on 2021/5/30.
//

import Foundation
import SwiftUI
import Combine

class CalculatorModel: ObservableObject {
//    let objectWillChange = PassthroughSubject<Void, Never>()
//    var brain: CalculatorBrain = .left("0") {
//        willSet { objectWillChange.send() }
//    }
    
    // 操作逻辑管理类
    @Published var brain: CalculatorBrain = .left("0")
    
    // 记录历史操作
    @Published var history: [CalculatorButtonItem] = []
    // 增加对应操作
    func apply(_ item: CalculatorButtonItem) {
        brain = brain.apply(item: item)
        history.append(item)
        
        // 历史回溯功能
        temporaryKept.removeAll()
        slidingIndex = Float(totalCount)
    }
    
    // historyDetail 将 history 数组中所记录的操作步骤的描述连接起来，作为履历 的输出字符串
    var historyDetail: String { history.map { $0.description }.joined() }
    // 在回溯操作时，除了维护 history 并让 historyDetail 反映当前的历史步骤的 同时，我们也希望保留那些 “被回溯” 的操作，这样我们可以还能使用滑块恢 复这些操作。用 temporaryKept 来暂存这些操作
    var temporaryKept: [CalculatorButtonItem] = []
    // 滑块的最大值应当是 history 和 temporaryKept 两个数组元素数量的和
    var totalCount: Int { history.count + temporaryKept.count }
    // 使用 slidingIndex 表示当前滑块表示的 index 值，这个值应该是 0 到 totalCount 之间的一个数字。
    var slidingIndex: Float = 0 {
        didSet {
            keepHistory(upTo: Int(slidingIndex))
        }
    }
    
    func keepHistory(upTo index: Int) {
        precondition(index <= totalCount, "Out of index.")
        
        let total = history + temporaryKept
        history = Array(total[..<index])
        temporaryKept = Array(total[index...])
        
        brain = history.reduce(CalculatorBrain.left("0"), { result, item in
            result.apply(item: item)
        })
    }
}
