//
//  DataViewController.swift
//  SpaceX(Storyboards)
//
//  Created by Воевский Даниил  on 09/11/2022.
//

import UIKit

class DataViewController: UIViewController {
    @IBOutlet weak var displayLabel: UILabel!
    var displayText: String?
    
    var index: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        displayLabel.text = displayText
    }
    


}
