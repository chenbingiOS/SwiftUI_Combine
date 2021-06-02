//
//  ContentView.swift
//  Calculator
//
//  Created by chenbing on 2021/5/29.
//

import SwiftUI

struct ContentView: View {
//    @State private var brain: CalculatorBrain = .left("0")
//    @ObservedObject var model = CalculatorModel()
    @EnvironmentObject var model: CalculatorModel
    
    @State private var editingHistory = false
    
    let scale: CGFloat = UIScreen.main.bounds.width / 414
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 12) {
            Spacer()
            
            Button("操作履历:\(self.model.history.count)") {
                editingHistory = true
            }.sheet(isPresented: $editingHistory, content: {
                HistoryView(model: model)
            })
            
            Text(model.brain.output)
                .font(.system(size: 76))
                .minimumScaleFactor(0.5)
                .padding(.trailing, 24 * scale)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
            
            Button("Test") {
                model.brain = .left("1.23")
            }
            
            CalculatorButtonPad()
                .padding(.bottom)
        }
        .padding()
    }
}

struct CalculatorButtonPad: View {
//    @Binding var brain: CalculatorBrain
//    var model: CalculatorModel
    
    let pad: [[CalculatorButtonItem]] = [
        [.command(.clear), .command(.flip), .command(.percent), .op(.divide)],
        [.digit(7), .digit(8), .digit(9), .op(.multiply),],
        [.digit(4), .digit(5), .digit(6), .op(.minus),],
        [.digit(1), .digit(2), .digit(3), .op(.plus),],
        [.digit(0), .dot, .op(.equal)],
    ]
    
    var body: some View {
        VStack(spacing: 8) {
            ForEach(pad, id:\.self) { row in
                CalculatorButtonRow(row: row)
            }
        }
    }
}

struct CalculatorButtonRow: View {
//    @Binding var brain: CalculatorBrain
//    var model: CalculatorModel
    @EnvironmentObject var model: CalculatorModel
    
    let row: [CalculatorButtonItem]
    
    var body: some View {
        HStack {
            ForEach(row, id: \.self) { item in
                CalculatorButton(title: item.title, size: item.size, backgroundColorName: item.backgroundColorName) {
//                    self.brain = self.brain.apply(item: item)
                    model.apply(item)
                }
            }
        }
    }
}

struct CalculatorButton: View {
    let fontSize: CGFloat = 38
    let title: String
    let size: CGSize
    let backgroundColorName: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            Text(title)
                .font(.system(size: fontSize))
                .foregroundColor(.white)
                .frame(width: size.width, height: size.height)
                .background(Color(backgroundColorName))
                .cornerRadius(size.width / 2)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
//            ContentView()
//                .previewDevice("iPhone SE (2nd generation)")
        }
    }
}
