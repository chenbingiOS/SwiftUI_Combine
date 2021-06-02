//
//  Sample.swift
//  PokeMaster
//
//  Created by chenbing on 2021/5/31.
//

import Foundation

#if DEBUG

extension Pokemon {
    static func sample(id: Int) -> Pokemon {
        return FileHelper.loadBundleJSON(file: "pokemon-\(id)")
    }
}

extension PokemonSpecies {
    static func sample(url: URL) -> PokemonSpecies {
        return FileHelper.loadBundleJSON(file: "pokemon-species-\(url.extractedID!)")
    }
}

extension Ability {
    
    static func sample(id: Int) -> Ability {
        return FileHelper.loadBundleJSON(file: "ability-\(id)")
    }
    
    static func sample(url: URL) -> Ability {
        sample(id: url.extractedID!)
    }
}

extension PokemonViewModel {
    static var all: [PokemonViewModel] = {
        (1...30).map { id in
            sample(id: id)
        }
    }()
    
    static func sample(id: Int) -> PokemonViewModel {
        let pokemon = Pokemon.sample(id: id)
        let species = PokemonSpecies.sample(url: pokemon.species.url)
        return PokemonViewModel(pokemon: pokemon, species: species)
    }
    
    static let samples: [PokemonViewModel] = [
        sample(id: 1),
        sample(id: 2),
        sample(id: 3)
    ]
}

#endif
