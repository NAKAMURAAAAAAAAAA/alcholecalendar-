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


class FirstViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance, UITableViewDelegate, UITableViewDataSource  {

    /*    //飲み物文字
    @IBOutlet weak var cocktailtext: UILabel!
    @IBOutlet weak var winetext: UILabel!
    @IBOutlet weak var highballtext: UILabel!
    @IBOutlet weak var beertext: UILabel!
     */
//他機能
    @IBOutlet weak var showdate: UILabel!
    @IBOutlet weak var showhungover: UILabel!
/*
    @IBOutlet weak var showbeer: UILabel!
    @IBOutlet weak var showhighball: UILabel!
    @IBOutlet weak var showwine: UILabel!
    @IBOutlet weak var showcocktail: UILabel!
 */
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //ボタン
    @IBOutlet weak var deletebutton: UIButton!
    @IBOutlet weak var calendar: FSCalendar!
    
    
    var selectedDate: Date?
    
    @IBAction func tapDeleteButtonAction(_ sender: Any) {
        //selectedDateがnilではない場合
        if let date = selectedDate{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let drunkday = formatter.string(from: date)
            
            //イベント削除
            let realm = try! Realm()
            let events = realm.objects(Event.self).filter("date == %@", drunkday)
            events.forEach{(event)in
                try! realm.write(){
                    realm.delete(event)
                }
            }
            //カレンダーの更新
            calendar.reloadData()
            
            //textfieldの初期化
  /*          showhungover.text = ""
            showbeer.text = ""
            showhighball.text = ""
            showwine.text = ""
            showcocktail.text = ""
            
            beertext.text = ""
            highballtext.text = ""
            winetext.text = ""
            cocktailtext.text = ""
 */
     }
    }
    
    
    
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        selectedDate = date
        
        //日程の表示
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let da = formatter.string(from: date)
        showdate.text = da
        
        //スケジュール取得
        let realm = try! Realm()
        let result = realm.objects(Event.self).filter("date = '\(da)'")
        
        showhungover.text = ""
        /*
        showbeer.text = ""
        showhighball.text = ""
        showwine.text = ""
        showcocktail.text = ""
        
        beertext.text = ""
        highballtext.text = ""
        winetext.text = ""
        cocktailtext.text = ""
 */
        
        for ev in result {
            if ev.date == da && (ev.beer > 0 || ev.highball > 0 || ev.wine > 0 || ev.cocktail > 0){
/*
                beertext.text = "ビール"
                highballtext.text = "ハイボール"
                winetext.text = "ワイン"
                cocktailtext.text = "チューハイ"
                
                showbeer.text = "× \(ev.beer)杯"
                showhighball.text = "× \(ev.highball)杯"
                showwine.text = "× \(ev.wine)杯"
                showcocktail.text = "× \(ev.cocktail)杯"
 */
                
                if ev.hungover == true{
                    showhungover.text = "二日酔い飲み"
                    showhungover.textColor = UIColor.red
                }else{
                    showhungover.text = "適正飲酒"
                    showhungover.textColor = UIColor.orange
                }
            }
        }
        
    }
    
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        let realm = try! Realm()
        
        let drinkdays = realm.objects(Event.self).filter("beer > 0 || highball > 0 || wine > 0 || cocktail > 0")
        let hungoverdays = realm.objects(Event.self).filter("hungover == true && (beer > 0 || highball > 0 || wine > 0 || cocktail > 0)")
        
        var drinkDays = [String]()
        var hungoverDays = [String]()
        
        for drinkday in drinkdays{
            drinkDays.append(drinkday.date)
        }
        
        for hungoverday in hungoverdays{
            hungoverDays.append(hungoverday.date)
        }
        // cellのデザインを変更
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let dataString = formatter.string(from: date)
        
        if hungoverDays.contains(dataString){
            return UIColor.red
        }else if drinkDays.contains(dataString){
            return UIColor.orange
        }else{
            return nil
        }
    }
    
    let kindofdrinks = ["beer", "highball", "wine", "cocktail"]
    //Tableview用
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    //追加④ セルに値を設定するデータソースメソッド（必須）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得する
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        //selectedDateがnilではない場合
        if let date = selectedDate{
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd"
            let drunkday = formatter.string(from: date)
            
            let realm = try! Realm()
            let events = realm.objects(Event.self).filter("date == %@", drunkday)
            
            cell.textLabel?.text = kindofdrinks[indexPath.row]
        return cell
        }else{
            cell.textLabel?.text = ""
            return cell
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
