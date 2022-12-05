//
//  Example.swift
//  RedSo
//
//  Created by Bruce Hsieh on 2022/11/23.
//

import UIKit

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


// KingFisher
class CatchImageView: UIImageView {
     
    // NSCache
    static var imageCache: [URL: UIImage] = [:]
    
    private var url: URL?
    
    func getImage(_ string: String?,
                  completeionHandler: ((UIImage?) -> Void)? = nil) {
        guard let string = string,
        let url = URL(string: string)  else {
            return
        }
        self.url = url
        if let cachedImage = CatchImageView.imageCache[url] {
            self.image = cachedImage
            print("find image cache!!")
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            print("send request")
            guard let data = data,
                    let image = UIImage(data: data) else {
                return
            }
            DispatchQueue.main.async {
                completeionHandler?(image)
            }
            if self.url == url {
                print("update image")
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            } else {
                print("current url is \(self.url)")
                print("fetch url is \(url)")
            }
            CatchImageView.imageCache[url] = image
        }.resume()
    }
}

