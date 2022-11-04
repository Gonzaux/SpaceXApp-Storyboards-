//
//  ViewController.swift
//  SpaceX(Storyboards)
//
//  Created by Воевский Даниил  on 02/11/2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var mainLabel: UILabel!
    
    var rocketModel: MainRocketDataModel? = nil
    
    let NService = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NService.getRockets { [weak self] (result) in
            switch result {
                
            case .success(let rocketModel):
                self?.rocketModel = rocketModel
            case .failure(let error):
                print("error:", error)
            }
        }
    }
         
}



//MARK: - NetworkServiceProtocol protocol
protocol RocketNetworkServiceProtocol {
    func getRockets(complitions: @escaping (Result<[MainRocketDataModel]?, Error>) -> ())
    
}
    

final class NetworkService: RocketNetworkServiceProtocol {
    
    func getRockets(complitions: @escaping (Result<[MainRocketDataModel]?, Error>) -> ()) {
        guard let url = URL(string: APIs.rockets) else { return }
        let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        URLSession.shared.dataTask(with: url ) { data, response, error in
            if let error = error {
                complitions(.failure(error))
                return
            }
            
            do {
                let obj = try decoder.decode([MainRocketDataModel].self, from: data!)
                complitions(.success(obj))
            } catch {
                complitions(.failure(error))
            }
        }.resume()
    }
}


/*class NetworkManagerA {
    func makeRequest() {
        
        guard let url = URL(string: APIs.rockets) else { return }
        let request = URLRequest(url: url)
                                 
        let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
     
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, let rocket = try? decoder.decode([MainRocketDataModel].self, from: data) {
                print(rocket[0].name)
             }
        }
     task.resume()
    }
}
*/
