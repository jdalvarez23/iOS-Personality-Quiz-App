//
//  ResultsViewController.swift
//  Personality Quiz
//
//  Created by student19 on 3/9/19.
//  Copyright © 2019 Jose Alvarez. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    // initialize storyboard components
    @IBOutlet weak var resultAnswerLabel: UILabel!
    
    @IBOutlet weak var resultDefinitionLabel: UILabel!
    
    var responses: [Answer]! // initialize responses variable from QuestionViewController 

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        calculatePersonalityResult() // call method that calculates user's personality
        navigationItem.hidesBackButton = true // hide back button in navigation bar
    }
    
    func calculatePersonalityResult() {
        
        var frequencyOfAnswers: [AnimalType: Int] = [:] // initialize empty dictionary that will hold the frequency of each response
        
        let responseTypes = responses.map {$0.type} // a simplified collection that maps each Answer object to its corresponding types
        
        // iterate through the collection and add or update the key/value pair in dictionary
        for response in responseTypes {
            frequencyOfAnswers[response] = (frequencyOfAnswers[response] ?? 0) + 1
        }
        
        // place each key/value pair into array and sort the value properties in descending order
        let frequentAnswersSorted = frequencyOfAnswers.sorted(by: {(pair1, pair2) -> Bool in
            return pair1.value > pair2.value
        })
        
        let mostCommonAnswer = frequentAnswersSorted.first!.key // set value to most common answer based on array sorting
        
        /* Can be simplied to one line by using the following: */
        // let mostCommonAnswer = frequencyOfAnswers.sorted {$0.1 > $1.1}.first!.key
        
        // update labels with data held in mostCommonAnswer
        resultAnswerLabel.text = "You are a \(mostCommonAnswer.rawValue)!"
        resultDefinitionLabel.text = mostCommonAnswer.definition
        
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
