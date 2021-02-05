//
//  ContentView.swift
//  Calculator
//
//  Created by mtAdmin on 2021/2/3.
//

import SwiftUI

struct ContentView: View {
    let scale: CGFloat = UIScreen.main.bounds.width / 414
    
    var body: some View {
//        VStack(spacing: 12) {
//            Spacer()
//
//            Text("0")
//                .font(.system(size: 76))
//                .lineLimit(1)
//                .minimumScaleFactor(0.5)
//                .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
//                .padding(.trailing, 24)
//
//            CalculatorButtonPad()
//                .padding(.bottom)
//        }
//        .scaleEffect(scale)
        
        VStack(spacing: 12) {
            Spacer()
            
            HStack {
                Spacer()
                
                Text("0")
                    .font(.system(size: 76))
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
            }
            
            CalculatorButtonPad()
                .padding(.bottom)
        }
//        .scaleEffect(scale)
    }
}

struct CalculatorButtonPad: View {
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
    let scale: CGFloat = UIScreen.main.bounds.width / 414
    
    let row: [CalculatorButtonItem]
    var body: some View {
        HStack(spacing: 8) {
            ForEach(row, id: \.self) { item in
                CalculatorButton(title: item.title,
                                 size: item.size,
                                 backgroundColorName: item.backgroundColorName) {
                    print("Button:\(item.title)")
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
//        Button(action: action) {
//            Text(title)
//                .font(.system(size: fondSize))
//                .foregroundColor(.white)
//                .frame(width: size.width, height: size.height)
//                .background(Color(backgroundColorName))
//                .cornerRadius(size.width / 2)
//        }
        
        Button(action: action) {
            ZStack {
                Capsule()
//                Circle()
                    .frame(width: size.width, height: size.height)
                    .foregroundColor(Color(backgroundColorName))
                Text(title)
                    .font(.system(size: fondSize))
                    .foregroundColor(.white)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
            .environment(\.colorScheme, .dark)
    }
}
