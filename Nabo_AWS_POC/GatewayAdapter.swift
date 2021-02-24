//
//  Data.swift
//  LearningSwift
//
//  Created by Rishab Dulam on 2/21/21.
//

import Foundation
import SwiftUI

class GatewayAdapter {
    static let shared = GatewayAdapter()
    
    func fetchImages(completion: @escaping (Result<ImageModel, Error>) -> Void) {
        var componentURL = URLComponents()
        componentURL.scheme = "https"
        componentURL.host = "6romz8nq6k.execute-api.us-east-2.amazonaws.com"
        componentURL.path = "/prod"
        
        guard let validURL = componentURL.url else {
            print("URL creation failed")
            return
        }
        
        URLSession.shared.dataTask(with: validURL) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                print("API status: \(httpResponse.statusCode)")
            }
            
            guard let validData = data, error == nil else {
                completion(.failure(error!))
                return
            }
            
            do {
                //let images = try JSONSerialization.jsonObject(with: validData, options: [])

                let images = try JSONDecoder().decode(ImageModel.self, from: validData)
                completion(.success(images))
            } catch let serializationError {
                print(serializationError.localizedDescription)
                completion(.failure(serializationError))
            }
        }.resume()
    }
}
