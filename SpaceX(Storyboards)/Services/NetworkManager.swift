//
//  NetworkManager.swift
//  SpaceX(Storyboards)
//
//  Created by Воевский Даниил  on 09/11/2022.
//

import Foundation

//MARK: - NetworkServiceProtocol protocol
protocol RocketNetworkManagerProtocol {
    func getRockets(complitions: @escaping (Result<[MainRocketDataModel]?, Error>) -> ())
    
}


final class NetworkManager: RocketNetworkManagerProtocol {
    
    func getRockets(complitions: @escaping (Result<[MainRocketDataModel]?, Error>) -> Void) {
        guard let url = URL(string: APIs.rockets) else { return }
        
        
        URLSession.shared.dataTask(with: url ) { data, response, error in
            
            //checking error
            if let error = error {
                complitions(.failure(error))
                return
            }
            // try to get data
            
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            guard let data = data else { return }
            do {
                let result = try decoder.decode([MainRocketDataModel].self, from: data)
                complitions(.success(result))
            } catch {
                complitions(.failure(error))
                print(error)
            }
        }.resume()
    }
}
