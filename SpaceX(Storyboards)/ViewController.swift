//
//  ViewController.swift
//  SpaceX(Storyboards)
//
//  Created by Воевский Даниил  on 02/11/2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var mainLabel: UILabel!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lazy var rocket = [MainRocketDataModel]()
        
        
       mainLabel.text = rocket[0].name
       
    }
}


//MARK: - NetworkServiceProtocol protocol
protocol RocketNetworkServiceProtocol {
    func getRockets(complitions: @escaping (Result<[MainRocketDataModel]?, Error>) -> ())
    
}
    

final class NetworkService: RocketNetworkServiceProtocol {
    
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
