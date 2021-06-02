//
//  FileHelper.swift
//  PokeMaster
//
//  Created by chenbing on 2021/6/1.
//

import Foundation

class FileHelper {
    
    static func loadJSON<T: Decodable>(from url: URL) throws -> T {
        let data = try Data(contentsOf: url)
        return try appDecoder.decode(T.self, from: data)
    }
    
    static func loadBundleJSON<T: Decodable>(file: String) -> T {
        guard let url = Bundle.main.url(forResource: file, withExtension: "json") else {
            fatalError("Resource not found: \(file)")
        }
        return try! loadJSON(from: url)
    }
    
    
}
