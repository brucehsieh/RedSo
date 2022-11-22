//
//  API.swift
//  RedSo
//
//  Created by Bruce Hsieh on 2022/11/21.
//

import Foundation

// MARK: - Welcome
struct Data: Codable {
    let results: [Result]
}

// MARK: - Result
struct Result: Codable {
    let id: String?
    let type: String
    let name, position: String?
    let expertise: [String]?
    let avatar: String?
    let url: String?
}

