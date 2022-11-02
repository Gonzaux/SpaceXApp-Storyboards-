//
//  Model.swift
//  SpaceX(Storyboards)
//
//  Created by Воевский Даниил  on 02/11/2022.
//

import Foundation

// MARK: - RocketModel
struct MainRocketDataModel: Decodable {
    let height, diameter: Dimensions
    let mass: Mass
    let firstStage, secondStage: Stage
    let payloadWeights: [PayloadWeight]
    let flickrImages: [String]
    let name: String
    let costPerLaunch: Int
    let firstFlight, country: String
}

extension MainRocketDataModel {
    struct Dimensions: Decodable {
        let meters, feet: Double
    }
        
    struct Mass: Decodable {
        let kg, lb: Int
    }
        
    struct Stage: Decodable {
        let engines: Int
        let fuelAmountTons: Double
        let burnTimeSec: Int?
        
    }
    struct PayloadWeight: Decodable {
        let id, name: String
        let kg, lb: Int
    }
}
