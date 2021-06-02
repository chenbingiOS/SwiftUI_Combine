//
//  Ability.swift
//  PokeMaster
//
//  Created by chenbing on 2021/5/31.
//

import Foundation

struct Ability: Codable {
    struct Name: Codable, LanguageTextEntry {
        let language: Language
        let name: String
        
        var text: String { name }
    }
    
    struct FlavorTextEntry: Codable, LanguageTextEntry {
        let language: Language
        let flavorText: String
        
        var text: String { flavorText }
    }
    
    let id: Int

    let names: [Name]
    let falvorTextEntryies: [FlavorTextEntry]
}
