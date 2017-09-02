//
//  entryMenu.swift
//  BasketBallBox
//
//  Created by Jimmy on 2017/8/3.
//  Copyright © 2017年 Jimmy. All rights reserved.
//

import UIKit

class entryMenu: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    
    let appMain = UIApplication.shared.delegate as! AppDelegate
    var cond1 : String?
    var cond2 : String?
    var test11 : String?
    let teamapicker = UIPickerView()
    let teambpicker = UIPickerView()
    let db = sqliteConnect()
    var team = [String]()
    
    @IBAction func gotobox(_ sender: Any) {
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "competition_list"){
            show(vc, sender: self)
        }
        
    }
    
    func select_team(){
        let point = db.select_team()
        
        while sqlite3_step(point) == SQLITE_ROW{
            let team_name = sqlite3_column_text(point, 0)
            let team_list = String(cString: team_name!)
            
            team += [team_list]
        }
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return team.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return team[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == teamapicker {
            cond1 = team[row]

        }else if pickerView == teambpicker{
            cond2 = team[row]

        }
        
               //print(cond1)
    }
    
    @IBAction func playGame(_ sender: Any) {
        // alertshow()
        
        let alert = UIAlertController(title: "請輸入球隊", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.default, handler: nil))
        
        alert.addAction(UIAlertAction(title: "開始比賽", style: .default, handler: {action in
            
            let cond1 = alert.textFields![0]
            let cond2 = alert.textFields![1]
            self.cond1 = cond1.text
            self.cond2 = cond2.text
            self.performSegue(withIdentifier: "gamebox", sender: self)
            
        }))
        alert.addTextField(configurationHandler: {(textField) in
                       textField.placeholder = "主場球隊"
                textField.inputView = self.teamapicker

            let time = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: {(time) in
            textField.text = self.cond1
            })
            
            }
        )
        alert.addTextField(configurationHandler: {(textField) in
            textField.placeholder = "客場球隊"
            textField.inputView = self.teambpicker
            let time = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: {(time) in
                textField.text = self.cond2
            })        }
            
        )
        
            self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gamebox"{
            let controller = segue.destination as! gamerecboxvc
           
                controller.cond1 = self.cond1
                controller.cond2 = self.cond2
                controller.currentime = get_currentime()
                controller.game_name = "\(self.cond1!) vs. \(self.cond2!)"
            //print(controller.test111)

        }
    }
    
    func get_currentime () -> String{
        let now = Date()
        let timeintervel : TimeInterval = now.timeIntervalSince1970
        let date = NSDate(timeIntervalSince1970: timeintervel)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "Taiwan/Taipei")
        
        let dateString = dateFormatter.string(from: date as Date)
        // print("formatted date is =  \(dateString)")
        return dateString
    }
    
    
    @IBAction func signin_player(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "signin_player"){
            show(vc, sender: self)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let db = sqliteConnect()
        db.creat_player()
        db.creat_game_box()
        db.creat_team_competition()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        teamapicker.dataSource = self
        teamapicker.delegate = self
        teambpicker.delegate = self
        teambpicker.dataSource = self
        
        select_team()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
