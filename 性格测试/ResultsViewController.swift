//
//  ResultsViewController.swift
//  性格测试
//
//  Created by HhhotDog on 2018/4/27.
//  Copyright © 2018年 Alexscott. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    //MARK: Properties
    var responses: [Answer]!
    @IBOutlet weak var resultAnswerLabel: UILabel!
    @IBOutlet weak var resultDefinitionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        calculatePersonalityResult()
    }

    //MARK: Utilities
    func calculatePersonalityResult() {
        var frequencyOfAnswers: [AnimalType: Int] = [:]
        let responseTypes = responses.map { $0.type }
        
        for response in responseTypes {
            frequencyOfAnswers[response] = (frequencyOfAnswers[response] ?? 0) + 1
        }
        //找到最频繁的type
        let mostCommonAnswer = frequencyOfAnswers.sorted { $0.value > $1.value}.first!.key
        
        resultAnswerLabel.text = "You are a \(mostCommonAnswer.rawValue)!"
        resultDefinitionLabel.text = mostCommonAnswer.definition
    }

}














