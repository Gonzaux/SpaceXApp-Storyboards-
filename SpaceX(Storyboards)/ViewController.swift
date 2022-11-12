//
//  ViewController.swift
//  SpaceX(Storyboards)
//
//  Created by Воевский Даниил  on 02/11/2022.
//

import UIKit

class MainViewController: UIViewController {
    
    private let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        networkManager.getRockets { Result in
            switch Result {
                
            case let .success(result): print(result![0].name)
            case let .failure(error): print(error)
                
            }
        }
    }
}
