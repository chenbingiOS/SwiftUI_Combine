//
//  Language.swift
//  PokeMaster
//
//  Created by chenbing on 2021/5/31.
//

import Foundation

struct Language: Codable {
    let name: String
    let url: URL
    
    var isCN: Bool { name == "zh-Hans" }
    var isEN: Bool { name == "en" }
}

protocol LanguageTextEntry {
    var language: Language { get }
    var text: String { get }
}

extension Array where Element: LanguageTextEntry {
    var EN: String { first { $0.language.isEN }?.text ?? "Unknown" }
    var CN: String { first { $0.language.isCN }?.text ?? EN }
}

