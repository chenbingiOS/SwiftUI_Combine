//
//  CalculatorApp.swift
//  Calculator
//
//  Created by mtAdmin on 2021/2/3.
//

import SwiftUI

@main
struct CalculatorApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(CalculatorModel())
        }
    }
}
