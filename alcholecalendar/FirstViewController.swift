//
//  FirstViewController.swift
//  alcholecalendar
//
//  Created by Kan Nakamura on 2019/02/02.
//  Copyright © 2019 Kan Nakamura. All rights reserved.
//

import UIKit
import FSCalendar
import CalculateCalendarLogic
import RealmSwift


class FirstViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance  {
    

    @IBOutlet weak var showdate: UILabel!
    @IBOutlet weak var showhungover: UILabel!
    @IBOutlet weak var showbeer: UILabel!
    @IBOutlet weak var showhighball: UILabel!
    @IBOutlet weak var showwine: UILabel!
    @IBOutlet weak var showcocktail: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        //日程の表示
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let da = formatter.string(from: date)
        showdate.text = da
        
        //スケジュール取得
        let realm = try! Realm()
        let result = realm.objects(Event.self).filter("date = '\(da)'")
        
        showhungover.text = ""
        showbeer.text = ""
        showhighball.text = ""
        showwine.text = ""
        showcocktail.text = ""
        for ev in result {
            if ev.date == da {
                showbeer.text = "ビール　× \(ev.beer)杯"
                showhighball.text = "ハイボール　× \(ev.highball)杯"
                showwine.text = "ワイン　× \(ev.wine)杯"
                showcocktail.text = "カクテル　× \(ev.cocktail)杯"
                
                if ev.hungover == true{
                    showhungover.text = "二日酔い飲み"
                }else{
                    showhungover.text = "適正飲酒"
                }
            }
        }
        
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        let realm = try! Realm()
        let result = realm.objects(Event.self).filter("hungover == true")
        var hungoverDays = [String]()
        for event in result{
                hungoverDays.append(event.date)
        }
        // cellのデザインを変更
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let dataString = formatter.string(from: date)
        if hungoverDays.contains(dataString){
        return UIColor.red
        }else if CupOfBeer.text == nil || CupOfHighball.text == nil || CupOfWine.text == nil || CupOfCocktail.text == nil{
            
        }else{
            return nil
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
