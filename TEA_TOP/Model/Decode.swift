//
//  Decode.swift
//  TEA_TOP
//
//  Created by Robert Lin on 2022/12/19.
//

import Foundation

func loadJsonFile(_ filename: String) -> (Data){
    let data: Data
    guard let file = Bundle.main.url(forResource: filename, withExtension: "json") else {
        fatalError()
    }
    do {
        data = try Data(contentsOf: file)
        return data
    } catch {
        fatalError()
    }
}

func decodeJsonData<T: Decodable>(_ data: Data) -> T {
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError()
    }
}
