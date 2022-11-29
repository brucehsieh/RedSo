//
//  DataStore.swift
//  RedSo
//
//  Created by Bruce Hsieh on 2022/11/21.
//

import Foundation

class API {
    
    static func makeURL(team: String, page: Int) -> URL? {
        guard var urlComponents = URLComponents(string: "https://us-central1-redso-challenge.cloudfunctions.net/catalog") else { return nil }
        let params:[String: Any] = [
            "team" : team,
            "page" : page
        ]
        urlComponents.queryItems = params.toQueryItem()
        return urlComponents.url
    }
    
    static func getData(team: String, page: Int, completionHandler: @escaping (CatalogResponse?, Error?) -> Void) {
        // 要改 urlcomponents + urlqueryitem 的形式
        guard let url = makeURL(team: team, page: page) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                if let data = data {
                    let json = String(data: data, encoding: .utf8)
                    print("[ERROR] JSON: \(json)")
                }
                completionHandler(nil, error)
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print(response.statusCode)
            }
            
            if let data = data {
                do {
                    let profileData = try JSONDecoder().decode(CatalogResponse.self, from: data)
                    completionHandler(profileData, nil)
                } catch {
                    if let json = try? JSONSerialization.jsonObject(with: data) {
                        print("[ERROR] JSON: \(json)")
                    }
                    
                    completionHandler(nil, error)
                }
            }
        }.resume()
    }
}

//MARK: - Get image
extension API {
    
//    func getProfileImage(handler: @escaping (Result<Data, Error>) -> Void) {
//        guard let url =  else {
//            handler(.failure(APIError.invalidURL))
//            return
//        }
//        URLSession.shared.dataTask(with: url) { data, _, error in
//            if let error = error {
//                handler(.failure(error))
//                return
//            }
//            if let data = data {
//                handler(.success(data))
//            }
//        }.resume()
//    }
    
    enum APIError: Error {
        case invalidURL
    }
}


