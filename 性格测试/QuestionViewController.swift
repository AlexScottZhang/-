//
//  QuestionViewController.swift
//  性格测试
//
//  Created by HhhotDog on 2018/4/27.
//  Copyright © 2018年 Alexscott. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    //MARK: Properties
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet weak var singleButton1: UIButton!
    @IBOutlet weak var singleButton2: UIButton!
    @IBOutlet weak var singleButton3: UIButton!
    @IBOutlet weak var singleButton4: UIButton!
    
    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet weak var multiLabel1: UILabel!
    @IBOutlet weak var multiLabel2: UILabel!
    @IBOutlet weak var multiLabel3: UILabel!
    @IBOutlet weak var multiLabel4: UILabel!
    @IBOutlet weak var multiSwitch1: UISwitch!
    @IBOutlet weak var multiSwitch2: UISwitch!
    @IBOutlet weak var multiSwitch3: UISwitch!
    @IBOutlet weak var multiSwitch4: UISwitch!
    
    
    @IBOutlet weak var rangedStackView: UIStackView!
    @IBOutlet weak var rangedLabel1: UILabel!
    @IBOutlet weak var rangedLabel2: UILabel!
    @IBOutlet weak var rangedSlider: UISlider!
    
    @IBOutlet weak var questionProgressView: UIProgressView!
    
    var questionIndex = 0
    var answersChosen: [Answer] = []
    
    var questions: [Question] = [
        Question(text: "你最喜欢下面那种食物?",
                 type: .single,
                 answers: [
                    Answer(text: "牛排", type: .dog),
                    Answer(text: "鱼类", type: .cat),
                    Answer(text: "胡萝卜", type: .rabbit),
                    Answer(text: "玉米", type: .turtle)
            ]),
        Question(text: "你最喜欢下面哪些活动/运动?",
                 type: .multiple,
                 answers: [
                    Answer(text: "游泳", type: .turtle),
                    Answer(text: "睡觉", type: .cat),
                    Answer(text: "拥抱", type: .rabbit),
                    Answer(text: "吃", type: .dog)
            ]),
        Question(text: "你有多喜欢汽车竞速比赛?",
                 type: .ranged,
                 answers: [
                    Answer(text: "一点儿不喜欢", type: .cat),
                    Answer(text: "令人紧张", type: .rabbit),
                    Answer(text: "稍微留意", type: .turtle),
                    Answer(text: "非常热爱", type: .dog)
            ])
    ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }

    //MARK: Actions
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answers
        
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
        
        nextQuestion()
    }
    
    @IBAction func multipleAnswerButtonPressed() {
        let currentAnswer = questions[questionIndex].answers
        
        if multiSwitch1.isOn {
            answersChosen.append(currentAnswer[0])
        }
        if multiSwitch2.isOn {
            answersChosen.append(currentAnswer[1])
        }
        if multiSwitch3.isOn {
            answersChosen.append(currentAnswer[2])
        }
        if multiSwitch4.isOn {
            answersChosen.append(currentAnswer[3])
        }
        
        nextQuestion()
    }
    
    @IBAction func rangedAnswerButtonPressed() {
        let currentAnswer = questions[questionIndex].answers
        
        let index = Int(round(rangedSlider.value * Float(currentAnswer.count - 1)))
        answersChosen.append(currentAnswer[index])
        
        nextQuestion()
    }
    
    //MARK: Utilities
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultsSegue" {
            let resultsViewController = segue.destination as! ResultsViewController
            resultsViewController.responses = answersChosen
        }
    }
    
    func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "ResultsSegue", sender: nil)
        }
    }
    
    //更改标题，并根据题目类型呈现不同问答方式
    func updateUI() {
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true
        
        let currentQuestion = questions[questionIndex]
        let currentAnswers = currentQuestion.answers
        let totalProgress = Float(questionIndex) / Float(questions.count)
        
        navigationItem.title = "问题 #\(questionIndex + 1)"
        questionLabel.text = currentQuestion.text
        questionProgressView.setProgress(totalProgress, animated: true)
        
        switch currentQuestion.type {
        case .single:
            updateSingleStack(using: currentAnswers)
        case .multiple:
            updateMultipleStack(using: currentAnswers)
        case .ranged:
            updateRangedStack(using: currentAnswers)
        }
    }
    
    func updateSingleStack(using answers: [Answer]) {
        singleStackView.isHidden = false
        singleButton1.setTitle(answers[0].text, for: .normal)
        singleButton2.setTitle(answers[1].text, for: .normal)
        singleButton3.setTitle(answers[2].text, for: .normal)
        singleButton4.setTitle(answers[3].text, for: .normal)
    }
    
    func updateMultipleStack(using answers: [Answer]) {
        multipleStackView.isHidden = false
        
        multiSwitch1.isOn = false
        multiSwitch2.isOn = false
        multiSwitch3.isOn = false
        multiSwitch4.isOn = false
        
        multiLabel1.text = answers[0].text
        multiLabel2.text = answers[1].text
        multiLabel3.text = answers[2].text
        multiLabel4.text = answers[3].text
    }
    
    func updateRangedStack(using answers: [Answer]) {
        rangedStackView.isHidden = false
        
        rangedSlider.setValue(0.5, animated: false)
        
        rangedLabel1.text = answers.first?.text
        rangedLabel2.text = answers.last?.text
    }

}
