//
//  ViewController.swift
//  YubisumaAPP
//
//  Created by 井関竜太郎 on 2021/01/25.


//NPCを作成する・
//画像ー＞拳の大きさと枠を考える。




import UIKit

class ViewController: UIViewController {
    
    let speechService = SpeechService()
    
    var number:Int = 0
    var win: Int = 0
    var life: Int = 3
    var choose: Int = 0
    var godHand: Int = 0
    
    @IBOutlet weak var left: UIButton!
    @IBOutlet weak var right: UIButton!
    @IBOutlet weak var start: UIButton!
    @IBOutlet weak var reset: UIButton!
    @IBOutlet weak var hart: UILabel!
    @IBOutlet weak var segument: UISegmentedControl!
    
    @IBOutlet weak var player1: UILabel!
    @IBOutlet weak var player2: UILabel!
    
    @IBOutlet weak var enemy1: UILabel!
    @IBOutlet weak var enemy2: UILabel!
    
    
    var hand = UIImage(named: "hand")!
    var Lhand = UIImage(named: "yubi")!
    var Rhand = UIImage(named: "yubi2")!
    
    var transScale = CGAffineTransform()
    var transMiller = CGAffineTransform()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        player1.text = "✊"
 
        player2.text = "✊"
  
        enemy1.text = "✊"
     
        enemy2.text = "✊"

        hart.text = "ライフ：❤️❤️❤️"
        view.backgroundColor = UIColor.white
        start.isHidden = true
        
        transMiller = CGAffineTransform(scaleX: -1.5, y: 1.5)
        transScale = CGAffineTransform(scaleX: 1.5, y: 1.5)
    }
    
    
    @IBAction func left(_ sender: Any) {
        number += 1
        godHand += 1
        left.isHidden = true
        
    }
    
    @IBAction func right(_ sender: Any) {
        number += 1
        godHand += 2
        right.isHidden = true
    }
    
    
    @IBAction func chooce(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            print("0")
            choose = 0
            start.isHidden = false
        case 1:
            print("1")
            choose = 1
            start.isHidden = false
        case 2:
            print("2")
            choose = 2
            start.isHidden = false
        case 3:
            print("3")
            choose = 3
            start.isHidden = false
        case 4:
            print("4")
            choose = 4
            start.isHidden = false
        default:
            print("該当なし")
        }
    }
    
    
    @IBAction func game(_ sender: Any) {
        left.isHidden = true
        right.isHidden = true
        segument.isHidden = true
        start.isHidden = true
        reset.isHidden = false
        
        
        speechService.say("いっせーのーーせ　\(choose)")
        //敵のランダム設定。。。表示と数はしっかりとできた。
        let iValue = Int.random(in: 0 ... 2)
        if iValue == 0 {
            enemy1.text = "✊"
            enemy1.transform = transScale
            enemy2.text = "✊"
            enemy2.transform = transScale
        }else if iValue == 1 {
            let enemy = Int.random(in: 0...1)
            if enemy == 0{
                enemy1.text = "✊"
                enemy1.transform = transScale
                //逆さ
                enemy2.text = "👍"
                enemy2.transform = transMiller
                
            }else{
                enemy1.text = "👍"
                enemy1.transform = transScale
                enemy2.text = "✊"
                enemy2.transform = transScale
            }
        }else if iValue == 2 {
            enemy1.text = "👍"
            enemy1.transform = transScale
            enemy2.text = "👍"
            enemy2.transform = transMiller
        }
        
        //何もあげない。
        if number == 0 {
            player1.text = "✊"
            player1.transform = transScale
            player2.text = "✊"
            player2.transform = transScale
        }else if number == 1 {
            if godHand == 1{
                //右のみ
                player1.text = "👍"
                player1.transform = transScale
                player2.text = "✊"
                player2.transform = transScale
            }else if godHand == 2 {
                //左のみ
                player1.text = "✊"
                player1.transform = transScale
                //逆さ
                player2.text = "👍"
                player2.transform = transMiller
                
            }
        }else if number == 2 {
            player1.text = "👍"
            player1.transform = transScale
            //逆さ
            player2.text = "👍"
            player2.transform = transMiller
        }
        
        if number + iValue == choose {
            player1.isHidden = true
            left.isHidden = true
            win += 1
        }else{
            life -= 1
        }
        
        if win == 2 {
            player2.isHidden = true
            right.isHidden = true
            let Clear = self.storyboard?.instantiateViewController(identifier: "Clear") as! Clear
            Clear.modalPresentationStyle = .fullScreen
            self.present(Clear, animated: true, completion: nil)
        }
        
        //ライフの管理　→ もし動画を見るとライフが一つ回復する？？　→ランダムにする。
        if life == 2 {
            hart.text = "ライフ：❤️❤️"
        }else if life == 1 {
            hart.text = "ライフ：❤️"
        }else if life ==  0 {
            hart.text = "ゲームオーバー"
            let gameOver = self.storyboard?.instantiateViewController(identifier: "Gameover") as! GameOver
            gameOver.modalPresentationStyle = .fullScreen
            self.present(gameOver, animated: true, completion: nil)
        }
    }
    
    
    
    @IBAction func reset(_ sender: Any) {
        number = 0
        godHand = 0
        start.isHidden = true
        reset.isHidden = true
        segument.isHidden = false
        
        player1.text = "✊"
        player1.transform = transScale
        player2.text = "✊"
        player2.transform = transScale
        enemy1.text = "✊"
        enemy1.transform = transScale
        enemy2.text = "✊"
        enemy2.transform = transScale
        
        if win == 0 {
            right.isHidden = false
            left.isHidden = false
        }else if win == 1 {
            right.isHidden = false
            left.isHidden = true
        }else{
            right.isHidden = true
            left.isHidden = true
        }
        
    }
}

