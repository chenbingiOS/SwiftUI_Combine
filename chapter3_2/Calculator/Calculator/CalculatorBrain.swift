//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by chenbing on 2021/5/30.
//

import Foundation

enum CalculatorBrain {
    case left(String)
    case leftOp(left: String, op: CalculatorButtonItem.Op)
    case leftOpRight(left: String, op: CalculatorButtonItem.Op, right: String)
    case error
}

var formatter: NumberFormatter {
    let f = NumberFormatter()
    f.minimumFractionDigits = 0
    f.maximumFractionDigits = 8
    f.numberStyle = .decimal
    return f
}

extension CalculatorBrain {
    
    var output: String {
        let result: String
        switch self {
        case .left(let left): result = left
        case .leftOp(let left, _): result = left
        case .leftOpRight(_, _, let right): result = right
        case .error: return "Error"
        }
        
        guard let value = Double(result) else {
            return "Error"
        }
        
        // value 强制类型转换 NSNumber
        return formatter.string(from: value as NSNumber)!
    }
    
    func apply(item: CalculatorButtonItem) -> CalculatorBrain {
        switch item {
        case let .digit(num):
            return apply(num: num)
        case .dot:
            return applyDot()
        case let .op(op):
            return apply(op: op)
        case let .command(command):
            return apply(command: command)
        }
    }
}

extension CalculatorBrain {
    private func apply(num: Int) -> CalculatorBrain {
        switch self {
        case let .left(left):
            return .left(left.apply(num: num))
        case let .leftOp(left, op):
            return .leftOpRight(left: left, op: op, right: "0".apply(num: num))
        case let .leftOpRight(left, op, right):
            return .leftOpRight(left: left, op: op, right: right.apply(num: num))
        case .error:
            return .left("0".apply(num: num))
        }
    }
    
    private func applyDot() -> CalculatorBrain {
        switch self {
        case let .left(left):
            return .left(left.applyDot())
        case let .leftOp(left, op):
            return .leftOpRight(left: left, op: op, right: "0".applyDot())
        case let .leftOpRight(left, op, right):
            return .leftOpRight(left: left, op: op, right: right.applyDot())
        case .error:
            return .left("0".applyDot())
        }
    }
    
    private func apply(op: CalculatorButtonItem.Op) -> CalculatorBrain {
        switch self {
        case let .left(left):
            switch op {
            case .plus, .minus, .multiply, .divide:
                return .leftOp(left: left, op: op)
            case .equal:
                return self
            }
        case let .leftOp(left, currentOp):
            switch op {
            case .plus, .minus, .multiply, .divide:
                return .leftOp(left: left, op: op)
            case .equal:
                if let result = currentOp.calculate(l: left, r: left) {
                    return .leftOp(left: result, op: currentOp)
                } else {
                    return .error
                }
            }
        case let .leftOpRight(left, currentOp, right):
            switch op {
            case .plus, .minus, .multiply, .divide:
                if let result = currentOp.calculate(l: left, r: right) {
                    return .leftOp(left: result, op: op)
                } else {
                    return .error
                }
            case .equal:
                if let result = currentOp.calculate(l: left, r: right) {
                    return .left(result)
                } else {
                    return .error
                }
            }
        case .error:
            return self
        }
    }
    
    private func apply(command: CalculatorButtonItem.Command) -> CalculatorBrain {
        switch command {
        // 清除
        case .clear:
            return .left("0")
        // 翻转
        case .flip:
            switch self {
            case let .left(left):
                return .left(left.flipped())
            case let .leftOp(left, op):
                return .leftOpRight(left: left, op: op, right: "-0")
            case let .leftOpRight(left, op, right):
                return .leftOpRight(left: left, op: op, right: right.flipped())
            case .error:
                return .left("-0")
            }
        // 百分比
        case .percent:
            switch self {
            case let .left(left):
                return .left(left.percentaged())
            case .leftOp:
                return self
            case let .leftOpRight(left, op, right):
                return .leftOpRight(left: left, op: op, right: right.percentaged())
            case .error:
                return .left("-0")
            }
        }
    }
}

extension String {
    // 左边的值拼接右边的值
    func apply(num: Int) -> String { self == "0" ? "\(num)" : "\(self)\(num)" }
    
    // 是否包含小数点
    var containsDot: Bool { contains(".") }
    // 右边的值增加小数点
    func applyDot() -> String { containsDot ? self : "\(self)." }
    
    // 返回一个布尔值，该值指示序列的初始元素是否与另一个序列中的元素相同。
    // 是否两个序列的第一个值是否是 "-"
    var startWithNegative: Bool { starts(with: "-") }
    // 值翻转
    func flipped() -> String {
        if startWithNegative {
            var s = self
            s.removeFirst()
            return s
        } else {
            return "-\(self)"
        }
    }
    
    // 百分比
    func percentaged() -> String { String(Double(self)! / 100) }
}

extension CalculatorButtonItem.Op {
    // 计算操作符
    func calculate(l: String, r: String) -> String? {
        guard let left = Double(l), let right = Double(r) else {
            print("输入的值不是数字")
            return nil
        }
        
        let result: Double?
        switch self {
        case .plus: result = left + right
        case .minus: result = left - right
        case .multiply: result = left * right
        case .divide: result = right == 0 ? nil : left / right
        case .equal: fatalError()
        }
        
        return result.map{ String($0) }
    }
}
