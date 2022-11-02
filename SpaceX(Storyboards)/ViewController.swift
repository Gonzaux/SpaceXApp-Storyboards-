//
//  ViewController.swift
//  SpaceX(Storyboards)
//
//  Created by Воевский Даниил  on 02/11/2022.
//

import UIKit

class ViewController: UIViewController {
    
    let NManager = NetworkManagerA()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NManager.makeRequest()
         
        }
}




class NetworkManagerA {
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
