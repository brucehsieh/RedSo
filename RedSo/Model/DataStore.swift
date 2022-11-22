//
//  DataStore.swift
//  RedSo
//
//  Created by Bruce Hsieh on 2022/11/21.
//

import Foundation

class DataStore {
    func getData(completionHandler: @escaping (Data?, Error?) -> Void) {
        guard var urlComponents = URLComponents(string: "https://us-central1-redso-challenge.cloudfunctions.net/catalog?team=rangers&page=0") else { return }
        
        guard let url = urlComponents.url else {
            print("Invalid URL")
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completionHandler(nil, error)
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print(response.statusCode)
            }
            
            if let data = data {
                do {
                    let profileData = try JSONDecoder().decode(Data.self, from: data)
                    completionHandler(profileData, nil)
                } catch {
                    completionHandler(nil, error)
                }
            }
        }.resume()
    }
//let url = "https://us-central1-redso-challenge.cloudfunctions.net/catalog?team=rangers&page=0"

//func getData(for url: String) {
//    URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
//        guard let data = data, error == nil else {
//            print("invalid URL")
//            return
//        }
//        var result: Data?
//        do {
//            result = try JSONDecoder().decode(Data.self, from: data)
//        }
//        catch {
//            print("failed to convert \(error.localizedDescription)")
//        }
//        guard let json = result else {
//            return
//        }
//        print(json.results.first?.id)
//    }.resume()
//}

}
