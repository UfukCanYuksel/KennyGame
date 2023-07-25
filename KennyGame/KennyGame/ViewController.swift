//
//  ViewController.swift
//  KennyGame
//
//  Created by ufuk can yüksel on 7.06.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var score = 0
    var hScore = 0
    var timer = Timer()
    var count = 0
    var kennyArray = [UIImageView]()
    var hideTimer = Timer()
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "Score : \(score)"
        let storedHS = UserDefaults.standard.object(forKey: "highScore")
        if storedHS == nil{
            hScore = 0
            highScoreLabel.text = "High Score : \(hScore)"
        }
        if let newScore = storedHS as? Int{
            hScore = newScore
            highScoreLabel.text = "High Score : \(hScore)"
        }
        
        // kullanıcının resme tıklamasına izin veriyor
        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true
        
        
        // kullanıcı bir görünüme tıkladığında ne olacak
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        
        // görsel ile recognizer'ı eşliyorum
        kenny1.addGestureRecognizer(recognizer1)
        kenny2.addGestureRecognizer(recognizer2)
        kenny3.addGestureRecognizer(recognizer3)
        kenny4.addGestureRecognizer(recognizer4)
        kenny5.addGestureRecognizer(recognizer5)
        kenny6.addGestureRecognizer(recognizer6)
        kenny7.addGestureRecognizer(recognizer7)
        kenny8.addGestureRecognizer(recognizer8)
        kenny9.addGestureRecognizer(recognizer9)
     
        kennyArray = [kenny1 , kenny2 , kenny3 , kenny4 , kenny5 , kenny6 , kenny7 , kenny8 , kenny9]
        
        //Timer
        count = 10
        timeLabel.text = String(count)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
        
    }
    
    @objc func hideKenny( ){
        
        for hide in kennyArray{
            hide.isHidden = true
        }
        let random  = Int(arc4random_uniform(UInt32(kennyArray.count-1)))
        kennyArray[random].isHidden = false
        
    }
    
    
    
    // tıklandığında ne olacağını yazdığım fonksiyon
    @objc func increaseScore ( ){
        score += 1
        scoreLabel.text = "Score : \(score)"
        
    }
    
    
    
    
    @objc func countDown(){
        
        count -= 1
        timeLabel.text = String(count)
        
        if count == 0 {
            
            timer.invalidate()
            hideTimer.invalidate()
            
            for hide in kennyArray{
                hide.isHidden = true
            }
            
            //HighScore
            if self.score > self.hScore {
                self.hScore = self.score
                self.highScoreLabel.text = "High Score : \(self.hScore)"
                UserDefaults.standard.set(self.hScore, forKey: "highScore")
                
            }
            
            
            
            //Alert
            let alert = UIAlertController(title: "Time's Up", message: "Dou you want to play again?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
            let replaceButton = UIAlertAction(title: "Replace", style: UIAlertAction.Style.default) { UIAlertAction in
                    
                //replace e basıldığında baştan başlatmak
                self.score = 0
                self.scoreLabel.text = "Score : \(self.score)"
                self.count = 10
                self.timeLabel.text = String(self.count)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideKenny), userInfo: nil, repeats: true)
                
                
            }
            alert.addAction(okButton)
            alert.addAction(replaceButton)
            self.present( alert, animated: true, completion: nil)
            
            
            
        }
        
        
    }
    
   


}

