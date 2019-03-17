//
//  QuestionViewController.swift
//  Personality Quiz
//
//  Created by student19 on 3/9/19.
//  Copyright © 2019 Jose Alvarez. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    // initialize storyboard components
    
    @IBOutlet weak var questionLabel: UILabel!
    /* Single Answer Question */
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet weak var singleButton1: UIButton!
    @IBOutlet weak var singleButton2: UIButton!
    @IBOutlet weak var singleButton3: UIButton!
    @IBOutlet weak var singleButton4: UIButton!
    /* Multiple Answer Question */
    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet weak var multiLabel1: UILabel!
    @IBOutlet weak var multiLabel2: UILabel!
    @IBOutlet weak var multiLabel3: UILabel!
    @IBOutlet weak var multiLabel4: UILabel!
    @IBOutlet weak var multiSwitch1: UISwitch!
    @IBOutlet weak var multiSwitch2: UISwitch!
    @IBOutlet weak var multiSwitch3: UISwitch!
    @IBOutlet weak var multiSwitch4: UISwitch!
    
    
    /* Ranged Answer Question */
    @IBOutlet weak var rangedStackView: UIStackView!
    @IBOutlet weak var rangedLabel1: UILabel!
    @IBOutlet weak var rangedLabel2: UILabel!
    @IBOutlet weak var rangedSlider: UISlider!
    
    
    @IBOutlet weak var questionProgressView: UIProgressView!

    
    
    
    // initialize and declare array with a question of each response type: single-answer, multiple-answer, and ranged response
    var questions: [Question] = [Question(text: "Which food do you like the most?", type: .single, answers: [
        Answer(text: "Steak", type: .dog),
        Answer(text: "Fish", type: .cat),
        Answer(text: "Carrots", type: .rabbit),
        Answer(text: "Corn", type: .turtle)
        ]), Question(text: "Which activities do you enjoy?", type: .multiple, answers: [
            Answer(text: "Swimming", type: .turtle),
            Answer(text: "Sleeping", type: .cat),
            Answer(text: "Cuddling", type: .rabbit),
            Answer(text: "Eating", type: .dog)]),
            Question(text: "How much do you enjoy car rides?", type: .ranged, answers: [
                Answer(text: "I dislike them", type: .cat),
                Answer(text: "I get a little nervous", type: .rabbit),
                Answer(text: "I barely notice them", type: .turtle),
                Answer(text: "I love them", type: .dog)
                ]
        )]
    
    var questionIndex = 0 // initialize and declare question index
    
    var answersChosen : [Answer] = [] // initializen empty collection that stores user's answers

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateUI() // call method that displays questions to the player
        questionProgressView.transform = questionProgressView.transform.scaledBy(x: 1, y: 5)
    }
    
    // method that executes when the user presses a single answer question button
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        
        let currentAnswers = questions[questionIndex].answers // initialize and set value to current question's answers
        
        // execute for button pressed
        switch sender {
        case singleButton1:
            answersChosen.append(currentAnswers[0])
        case singleButton2:
            answersChosen.append(currentAnswers[1])
        case singleButton3:
            answersChosen.append(currentAnswers[2])
        case singleButton4:
            answersChosen.append(currentAnswers[3])
        default:
            break
        }
        
        nextQuestion() // call method that displays the next question
        
    }
    
    // method that executes when the user presses a multiple answer question button
    @IBAction func multipleAnswerButtonPressed(_ sender: UIButton) {
        
        let currentAnswers = questions[questionIndex].answers // initialize and set value to current question's answers
        
        // execute if first switch has "on" state
        if multiSwitch1.isOn {
            answersChosen.append(currentAnswers[0])
        }
        
        // execute if second switch has "on" state
        if multiSwitch2.isOn {
            answersChosen.append(currentAnswers[1])
        }
        
        // execute if third switch has "on" state
        if multiSwitch3.isOn {
            answersChosen.append(currentAnswers[2])
        }
        
        // execute if fourth switch has "on" state
        if multiSwitch4.isOn {
            answersChosen.append(currentAnswers[3])
        }
        
        nextQuestion() // call method that displays next question
    }
    
    
    @IBAction func rangedAnswerButtonPressed(_ sender: UIButton) {
        
        let currentAnswers = questions[questionIndex].answers // initialize and set value to current question's answers
        
        let index = Int(round(rangedSlider.value * Float(currentAnswers.count - 1))) // set value to slider index
        
        answersChosen.append(currentAnswers[index])
        
        nextQuestion() // call method that displays next question
        
    }
    
    // reusable method that displays each question to the player
    func updateUI() {
        // hide stack views
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true
        
        navigationItem.title = "Question #\(questionIndex + 1)" // set title to question number
        
        let currentQuestion = questions[questionIndex] // initialize and declare current question
        
        let currentAnswers = currentQuestion.answers // initialize and set value to current question's answers
        
        let totalProgress = Float(questionIndex) / Float(questions.count) // initialize and set value to math expression value
        
        print("Total Progress:", totalProgress)
        
        questionLabel.text = currentQuestion.text // set label text to current question
        
        questionProgressView.setProgress(totalProgress, animated: true)
        
        // execute for question type
        switch currentQuestion.type {
        case .single:
            updateSingleStack(using: currentAnswers) // call method to update question's answers UI
        case .multiple:
            updateMultipleStack(using: currentAnswers) // call method to update question's answers UI
        case .ranged:
            updateRangedStack(using: currentAnswers)
        }
        
    }
    
    // method that updates single question UI elements
    func updateSingleStack(using answers: [Answer]) {
        
        singleStackView.isHidden = false // display stack view
        
        // set button text to question answers' value
        singleButton1.setTitle(answers[0].text, for: .normal)
        singleButton2.setTitle(answers[1].text, for: .normal)
        singleButton3.setTitle(answers[2].text, for: .normal)
        singleButton4.setTitle(answers[3].text, for: .normal)
        
    }
    
    // method that updates multiple question UI elements
    func updateMultipleStack(using answers: [Answer]) {
        
        multipleStackView.isHidden = false // display stack view
        // default values back to original
        multiSwitch1.isOn = false
        multiSwitch2.isOn = false
        multiSwitch3.isOn = false
        multiSwitch4.isOn = false
        
        // set label text to question answer's value
        multiLabel1.text = answers[0].text
        multiLabel2.text = answers[1].text
        multiLabel3.text = answers[2].text
        multiLabel4.text = answers[3].text
        
    }
    
    // method that updates range question UI elements
    func updateRangedStack(using answers: [Answer]) {
        
        rangedStackView.isHidden = false // display stack view
        
        // set value back to original
        rangedSlider.setValue(0.5, animated: false)
        
        
        // set range label text to question answer's value
        rangedLabel1.text = answers.first?.text
        rangedLabel2.text = answers.last?.text
        
    }
    
    // method that displays the next question
    func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "ResultsSegue", sender: nil) // change view controller to result view controller
        }
        
    }
    
    // method that passes data to other segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // execute if expected segue is ResultsSegue
        if segue.identifier == "ResultsSegue" {
            let resultsViewController = segue.destination as! ResultsViewController // set value to ResultsViewController
            resultsViewController.responses = answersChosen // pass chosen answers to ResultsViewController & set value to chosen answers
        }
        
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
