//
//  Pokemon.swift
//  PokeMaster
//
//  Created by chenbing on 2021/5/31.
//

import Foundation

struct Pokemon: Identifiable, Codable {
    
    struct `Type`: Codable {
        struct Internal: Codable {
            let name: String
            let url: URL
        }
        
        let slot: Int
        let type: Internal
    }

    struct AbilityEntry: Codable {
        struct Internal: Codable {
            let name: String
            let url: URL
        }
        
        var id: URL { apility.url }
        
        let slot: Int
        let apility: Internal
    }

    struct Stat: Codable {
        enum Case: String, Codable {
            case speed
            case specialDefense = "special-defense"
            case specialAttack = "special-attack"
            case defense
            case attack
            case hp
        }
        
        struct Internal: Codable {
            let name: Case
        }
        
        let baseStat: Int
        let stat: Internal
    }

    struct SpeciesEntry: Codable {
        let name: String
        let url: URL
    }
    
    let id: Int
    let types: [Type]
    let abilities: [AbilityEntry]
    let stats: [Stat]
    let species: SpeciesEntry
    let height: Int
    let weight: Int
}
