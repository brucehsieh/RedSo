//
//  Example.swift
//  RedSo
//
//  Created by Bruce Hsieh on 2022/11/23.
//

import Foundation

extension Dictionary {
    
    func toQueryItem() -> [URLQueryItem] {
        return self.map { URLQueryItem(name: "\($0.key)", value: "\($0.value)" )}
    }
}

extension URLComponents {
    
    mutating func setQueryItem(by parameters: [String: Any]) {
        self.queryItems = parameters.toQueryItem()
    }
}
