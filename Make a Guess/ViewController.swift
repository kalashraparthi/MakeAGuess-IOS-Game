    //
    //  ViewController.swift
    //  Make a Guess
    //
    //  Created by Student on 2019-10-12.
    //  Copyright © 2019 Studentfirst. All rights reserved.
    //

    import UIKit
    import AVFoundation
    class ViewController: UIViewController {

    var audioPlayer : AVAudioPlayer!
    var randomNumber : Int = 0
    var result : Double = 0
    var userChoice : Int = 0
    var absVal : Double = 0.0
    var range : Double = 0.0
    var counter : Int = 0
    var sound : String = ""
    //an array to store score of 3 attempts
    var totalResult = [Int]()
    var totalScore : Int = 0
    @IBOutlet weak var slider : UISlider!
    @IBOutlet weak var randomLabel : UILabel!
    @IBOutlet weak var resultLabel : UILabel!
    @IBOutlet weak var hintLabel : UILabel!

    @IBAction func scoreButton(_ sender: Any) {
        
        totalScore = totalResult[0]+totalResult[1]+totalResult[2]
        let vc = storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController
        vc?.myScore = "The first attempt is : \(totalResult[0])/100\n\nThe second attempt is : \(totalResult[1])/100\n\nThe third attempt is : \(totalResult[2])/100\n\nYour total score is : \(totalScore)/300";
        
        navigationController?.pushViewController(vc!, animated: true);
        reset()
    }

    @IBOutlet weak var scoreButton: UIButton!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var tryButton: UIButton!
    @IBOutlet weak var easyButton: UIButton!
    @IBOutlet weak var mediumButton: UIButton!
    @IBOutlet weak var hardButton: UIButton!
    @IBOutlet weak var hintButton: UIButton!

    // Easy level button - Default level - 1-10
    @IBAction func beginnerButton(_ sender: Any) {
        easyButton.backgroundColor = UIColor.orange
        mediumButton.backgroundColor = UIColor.white
        hardButton.backgroundColor = UIColor.white
        slider.maximumValueImage = UIImage(named: "10.png")
        totalResult.removeAll()
        reset()
        slider.maximumValue = 10
        range = Double(slider.maximumValue)
    }

    // Medium level button - 0-50
    @IBAction func intermediateButton(_ sender: Any) {
        mediumButton.backgroundColor = UIColor.orange
        easyButton.backgroundColor = UIColor.white
        hardButton.backgroundColor = UIColor.white
        slider.maximumValueImage = UIImage(named: "50.png")
        totalResult.removeAll()
        reset()
        slider.maximumValue = 50
        range = Double(slider.maximumValue)
    }

    // Hard level button - 0-100
    @IBAction func advancedButton(_ sender: Any) {
        hardButton.backgroundColor = UIColor.orange
        easyButton.backgroundColor = UIColor.white
        mediumButton.backgroundColor = UIColor.white
        slider.maximumValueImage = UIImage(named: "100.png")
        totalResult.removeAll()
        reset()
        slider.maximumValue = 100
        range = Double(slider.maximumValue)
    }

    // Slider Control
    @IBAction func sliderValue(_ sender: Any) {
    }

    // Reset button functionality call
    @IBAction func resetButton(_ sender: Any) {
        reset()
        
    }

    // Check button functionality call
    @IBAction func checkButton(_ sender: Any) {
        checkButton.isEnabled = false
        check()
    }


    // Hint button functionality call
    @IBAction func hintButton(_ sender: Any) {
        hint()
    }

    // Try button
    @IBAction func tryButton(_ sender: Any) {
        counter = 0
        randomLabel.isHidden = false
        hintLabel.isHidden = true
        checkButton.isEnabled = true
        hintButton.isEnabled = true
        range = Double(slider.maximumValue)
        randomNumber = Int.random(in: 1 ... Int(range))
        randomLabel.text = "The random number is : \(randomNumber)"
    }

    // generate a random number using the shake feature
    override func becomeFirstResponder() -> Bool {
        return true
    }

    //shjake gesture
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            tryButton(self)
        }
    }
        

    ////////////////////////////////////////////////////////////////////////Check functionality//////////

    func check(){
        randomLabel.isHidden = false
        resultLabel.isHidden = false
        hintLabel.isHidden = true
        
        // Receiving input from user using the slider
        userChoice = Int(slider.value)
        
        // Correct guess
        if userChoice == randomNumber
        {
            sound = "bubbles"
            result = 100
            resultLabel.text  = "Score: \(Int(result))"
        }
            
       // Wrong guesses, the difference is absolute to eleminate negative numbers and normalized to give score
            
        else{
            sound = "beep"
            absVal = Double(abs(userChoice - randomNumber))
            result = (1 - absVal/range ) * 100
            resultLabel.text = "Score: \(Int(result))"
        }
        
        //Sounds Play
        if let soundURL = Bundle.main.url(forResource: sound, withExtension: "mp3") {
            
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            }
            catch {
                print(error)
            }
            
            audioPlayer.play()
        }else{
            print("Unable to locate audio file")
        }
        
        // Allowing the user to have 3 attempts per game
        // the result array only stores 3 scores for three attempts
        if(totalResult.count < 3)
        {
            totalResult.append(Int(result))
            //print(totalResult[totalResult.count-1])
            scoreButton.isHidden = true
        }
        if(totalResult.count == 3){
            resetPartially()
            scoreButton.isHidden = false
        }
    }

    /////////////////////////////////////////////////////////////////////Hint feature//////////

        func hint(){
            hintLabel.isHidden = false
            let hintOutput = Int(slider.value) - randomNumber
            
            if (hintOutput > 0) {
                hintLabel.text = "Your guess is high"
            }
                
            else if (hintOutput < 0 ){
                hintLabel.text = "Your guess is low"
            }
                
            else {
                hintLabel.text = "Your guess is correct"
            }
            counter += 1
            if ( counter == 3){
                hintLabel.isHidden = true
                hintButton.isEnabled = false
                counter = 0
            }
            print(counter)
            
        }
        func resetPartially(){
            hintLabel.isHidden = true
            hintLabel.text = ""
            slider.value = 0
            randomNumber = 0
            scoreButton.isHidden = true
            checkButton.isEnabled = false
            hintButton.isEnabled = false
        }

    ////////////////////////////////////////////////////////////////////////Reset functionality///////

        func reset(){
            randomLabel.isHidden = true
            randomLabel.text = ""
            resultLabel.isHidden = true
            resultLabel.text = ""
            resetPartially()
            totalResult.removeAll()
            //print(totalResult)
        }
        override func viewDidLoad() {
            super.viewDidLoad()
      
            easyButton.backgroundColor = UIColor.orange
            hintLabel.isHidden = true
            randomLabel.isHidden = true
            resultLabel.isHidden = true
            scoreButton.isHidden = true
            checkButton.isEnabled = false
            hintButton.isEnabled = false
            setNeedsStatusBarAppearanceUpdate()
        
        }

        override var prefersStatusBarHidden: Bool{
            return true
        }
    }

