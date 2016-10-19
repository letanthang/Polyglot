//
//  TestViewController.swift
//  Polyglot
//
//  Created by Thang Le Tan on 10/19/16.
//  Copyright © 2016 Thang Le Tan. All rights reserved.
//

import UIKit
import GameplayKit

class TestViewController: UIViewController {
    
    var words: [String]!
    var questionCounter = 0
    var showQuestion = true

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var promt: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .fastForward, target: self, action: #selector(nextTapped))
        words = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: words) as! [String]
        
        title = "TEST"
        stackView.alpha = 0
        stackView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)

        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        askQuestion()
        
    }
    
    func nextTapped() {
        
        showQuestion = !showQuestion
        
        if showQuestion {
            prepareForQuestion()
        } else {
            promt.text = words[questionCounter].components(separatedBy: "::")[0]
            promt.textColor = UIColor(red: 0, green: 0.7, blue: 0, alpha: 1)
        }
        
    }
    
    func prepareForQuestion() {
        let animator = UIViewPropertyAnimator(duration: 0.4, curve: .easeOut, animations: {
            self.stackView.alpha = 0
            self.stackView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        })
        
        animator.addCompletion { (position) in
            self.askQuestion()
        }
        
        animator.startAnimation()
    }
    
    func askQuestion() {
        
        questionCounter += 1
        
        if questionCounter == words.count {
            questionCounter = 0
        }
        
        promt.text = words[questionCounter].components(separatedBy: "::")[1]
        promt.textColor = UIColor.black
        
        
        
        let animator = UIViewPropertyAnimator(duration: 1, dampingRatio: 0.5, animations: {
            self.stackView.alpha = 1
            self.stackView.transform = CGAffineTransform.identity
        })
        
        animator.startAnimation()
        
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
