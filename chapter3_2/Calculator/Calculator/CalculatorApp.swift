//
//  CalculatorApp.swift
//  Calculator
//
//  Created by chenbing on 2021/5/29.
//

import SwiftUI

@main
struct CalculatorApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(CalculatorModel())
        }
    }
}
