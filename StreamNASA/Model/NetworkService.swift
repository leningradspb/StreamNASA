//
//  NetworkService.swift
//  StreamNASA
//
//  Created by Eduard Sinyakov on 11/13/19.
//  Copyright © 2019 Eduard Siniakov. All rights reserved.
//

import Foundation
class NetworkService {
     func request(urlString: String, completion: @escaping (Result<SearchResponse, Error>) -> Void) {
            guard let url = URL(string: urlString) else {return}
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                DispatchQueue.main.async {
                    if let error = error {
                        print("Some error")
                      //  completion(nil, error)
                        completion(.failure(error))
                        return
                    }
                    guard let data = data else {return}
    //                let someString = String(data: data, encoding: .utf8)
    //                print(someString ?? "No data")
                    do {
                        let nasaItems = try JSONDecoder().decode(SearchResponse.self, from: data)
                       // completion(tracks, nil)
                        completion(.success(nasaItems))
						//print(nasaItems)
                    } catch let jsonError {
                        print("Failed to decode json")
                        print(jsonError)
                       // completion(nil, jsonError)
                        completion(.failure(jsonError))
                    }


                }
            }.resume()
        }
}

// https://images-api.nasa.gov/search?q=space
