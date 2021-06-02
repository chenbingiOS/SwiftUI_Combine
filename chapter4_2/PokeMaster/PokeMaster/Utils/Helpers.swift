//
//  Helpers.swift
//  PokeMaster
//
//  Created by chenbing on 2021/5/31.
//

import Foundation
import SwiftUI

let appDecoder: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return decoder
}()

let appEncoder: JSONEncoder = {
    let encoder = JSONEncoder()
    encoder.keyEncodingStrategy = .convertToSnakeCase
    return encoder
}()

extension URL {
    var extractedID: Int? {
        Int(lastPathComponent)
    }
}

extension Color {
    init(hex: Int, alpha: Double = 1) {
        let compoents = (
            R: Double((hex >> 16) & 0xff) / 255,
            G: Double((hex >> 08) & 0xff) / 255,
            B: Double((hex >> 00) & 0xff) / 255
        )
        self.init(.sRGB, red: compoents.R, green: compoents.G, blue: compoents.B, opacity: alpha)
    }
}

extension String {
    // 移除换行为空格
    var newLineRemoved: String {
        return split(separator: "\n").joined(separator: " ")
    }
}
