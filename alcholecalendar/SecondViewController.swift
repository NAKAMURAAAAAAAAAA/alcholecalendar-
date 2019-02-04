//
//  SecondViewController.swift
//  alcholecalendar
//
//  Created by Kan Nakamura on 2019/02/02.
//  Copyright © 2019 Kan Nakamura. All rights reserved.
//

import UIKit
import RealmSwift

class SecondViewController: UIViewController {

    @IBOutlet weak var day: UIDatePicker!
    @IBOutlet weak var CupOfBeer: UITextField!
    @IBOutlet weak var CupOfHighball: UITextField!
    @IBOutlet weak var CupOfWine: UITextField!
    @IBOutlet weak var CupOfCocktail: UITextField!
    var whichisswitch = false
    @IBAction func HungoverSwitch(_ sender: UISwitch) {
        if sender.isOn == true {
            whichisswitch = true
            print(sender.isOn)
        } else {
            whichisswitch = false
        }
    }
    @IBAction func Done(_ sender: Any) {
        //UIDatePickerからDateを取得する
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let drunkday = formatter.string(from: day.date)
        
        //データ型の変換
        let beernumber = CupOfBeer.text
        let beernum = Int(beernumber!)!
        let highballnumber = CupOfHighball.text
        let highballnum = Int(highballnumber!)!
        let winenumber = CupOfWine.text
        let winenum = Int(winenumber!)!
        let cocktailnumber = CupOfCocktail.text
        let cocktailnum = Int(cocktailnumber!)!
        
        //データ書き込み
        print("データ書き込み開始")
        let realm = try! Realm()
        try! realm.write{
            //日付表示の内容とスケジュール入力の内容が書き込まれる。
            let Events = [Event(value: ["date": drunkday, "beer": beernum, "highball": highballnum, "wine": winenum, "cocktail": cocktailnum, "hungover": whichisswitch])]
            realm.add(Events)
            print("データ書き込み中")
        }
        print("データ書き込み完了")
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        CupOfBeer.keyboardType = UIKeyboardType.numberPad
        CupOfHighball.keyboardType = UIKeyboardType.numberPad
        CupOfWine.keyboardType = UIKeyboardType.numberPad
        CupOfCocktail.keyboardType = UIKeyboardType.numberPad
    }


}

