//
//  NetworkManager.swift
//  MagicBall
//
//  Created by Alex Hanina on 1/22/22.
//

import Foundation

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func downloadAnswersData(onSuccess: @escaping(AnswersData) -> Void, onError: @escaping(String) -> Void)  {
        guard let question = "Is it my best day?".encodeURIComponent() else {
            print("Error")
            return
        }
        
        let session = URLSession.shared
        let decoder = JSONDecoder()
        let urlBuilder = URLBuilder()
        
        urlBuilder.base()
        urlBuilder.magic()
        urlBuilder.JSON()
        urlBuilder.questionString(question: question)
        guard let url = URL(string: urlBuilder.build()) else {
            print("URL building error")
            return
        }
        
        session.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
                onError(error.localizedDescription)
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse else {
                onError("Invalid data or response")
                return
            }
            
            do {
                if response.statusCode == 200 {
                    let item = try decoder.decode(AnswersData.self, from: data)
                    onSuccess(item)
                } else {
                    onError("Response wasn't 200. It was: \(response.statusCode)")
                }
            } catch {
                print(error)
                onError(error.localizedDescription)
            }
        }.resume()
    }
}

