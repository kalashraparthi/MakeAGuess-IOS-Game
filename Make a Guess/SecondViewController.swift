    //
    //  SecondViewController.swift
    //  Make a Guess
    //
    //  Created by Student on 2019-10-14.
    //  Copyright © 2019 Studentfirst. All rights reserved.
    //

    import UIKit

    class SecondViewController: UIViewController {


    var myScore = ""


    @IBOutlet weak var scoreLabel: UILabel!




    override func viewDidLoad() {
        super.viewDidLoad()

        
        scoreLabel.text = myScore
        // Do any additional setup after loading the view.
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
