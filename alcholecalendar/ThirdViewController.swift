//
//  ThirdViewController.swift
//  alcholecalendar
//
//  Created by Kan Nakamura on 2019/02/02.
//  Copyright © 2019 Kan Nakamura. All rights reserved.
//

import UIKit
import RealmSwift

class ThirdViewController: UIViewController {

   
    @IBOutlet weak var CupOfHungover: UILabel!
    
    func getstatus() -> String?{
        let realm = try! Realm()
        let results = realm.objects(Event.self).filter("hungover == true && (beer > 0 || highball > 0 || wine > 0 || cocktail > 0)")
        if results.count > 1{
        var sum = 0
        for res in results{
            let alchole = res.beer + res.highball + res.wine + res.cocktail
            sum += alchole
        }
        return "\(sum / results.count)杯"
        }else{
            return "二日酔いデータ不足"
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CupOfHungover.text = getstatus()
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
