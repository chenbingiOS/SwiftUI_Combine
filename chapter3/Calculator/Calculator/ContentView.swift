//
//  ContentView.swift
//  Calculator
//
//  Created by mtAdmin on 2021/2/3.
//

import SwiftUI

struct ContentView: View {
//    @State private var brain: CalculatorBrain = .left("0")
//    @ObservedObject var model = CalculatorModel()
//    var model: CalculatorModel
    @EnvironmentObject var model: CalculatorModel
    @State private var editingHistory = false
    @State private var showingResult = false
    
    let scale: CGFloat = UIScreen.main.bounds.width / 414
    
    var body: some View {
        VStack(spacing: 12) {
            
            HistoryView(model: self.model, isPresented: self.$editingHistory)
            
            Spacer()
            Button("操作履历:\(model.history.count)") {
//                print(self.model.history)
                self.editingHistory = true
            }.sheet(isPresented: self.$editingHistory, content: {
                HistoryView(model: self.model, isPresented: self.$editingHistory)
            })
            Text(model.brain.output)
                .font(.system(size: 76))
                .lineLimit(1)
                .foregroundColor(.black)
                .minimumScaleFactor(0.5)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing, 24)
                .onTapGesture {
                    self.showingResult.toggle()
                }
                .alert(isPresented: self.$showingResult) {
                    Alert(title: Text(self.model.historyDetail),
                          message: Text(self.model.brain.output),
                          primaryButton: .default(Text("Copy"), action: {
                            UIPasteboard.general.string = self.model.brain.output
                          }),
                          secondaryButton: .cancel())
                }

//            Button("Text") {
//                self.model.brain = .left("1.24")
//            }
            
            CalculatorButtonPad()
                .padding(.bottom)
        }
        .scaleEffect(scale)
        
//        VStack(spacing: 12) {
//            Spacer()
//
//            HStack {
//                Spacer()
//
//                Text("0")
//                    .font(.system(size: 76))
//                    .lineLimit(1)
//                    .minimumScaleFactor(0.5)
//            }
//
//            CalculatorButtonPad()
//                .padding(.bottom)
//        }
//        .scaleEffect(scale)
    }
}

struct CalculatorButtonPad: View {
//    @Binding var brain: CalculatorBrain
//    var model: CalculatorModel
    
    let rows: [[CalculatorButtonItem]] = DataAll.row1
    var body: some View {
        VStack(spacing: 8) {
            ForEach(rows, id: \.self) { row in
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
        HStack(spacing: 8) {
            ForEach(row, id: \.self) { item in
                CalculatorButton(title: item.title,
                                 size: item.size,
                                 backgroundColorName: item.backgroundColorName) {
                    print("Button:\(item.title)")
//                    self.brain = self.brain.apply(item: item)
                    self.model.apply(item)
                }
            }
        }
    }
}

struct CalculatorButton: View {
    let fondSize: CGFloat = 38
    let title: String
    let size: CGSize
    let backgroundColorName: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: fondSize))
                .foregroundColor(.white)
                .frame(width: size.width, height: size.height)
                .background(Color(backgroundColorName))
                .cornerRadius(size.width / 2)
        }
        
//        Button(action: action) {
//            ZStack {
//                Capsule()
////                Circle()
//                    .frame(width: size.width, height: size.height)
//                    .foregroundColor(Color(backgroundColorName))
//                Text(title)
//                    .font(.system(size: fondSize))
//                    .foregroundColor(.white)
//            }
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
            .environment(\.colorScheme, .dark)
    }
}
