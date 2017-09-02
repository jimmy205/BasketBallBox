//
//  pick_up_player.swift
//  BasketBallBox
//
//  Created by Jimmy on 2017/8/4.
//  Copyright © 2017年 Jimmy. All rights reserved.
//

import UIKit

class pick_up_player: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    @IBOutlet weak var home_team: UILabel!
    @IBOutlet weak var guest_team: UILabel!
    
    @IBOutlet weak var h_home_team: UITextField!
    @IBOutlet weak var h_home_p1: UITextField!
    @IBOutlet weak var h_home_p2: UITextField!
    @IBOutlet weak var h_home_p3: UITextField!
    @IBOutlet weak var h_home_p4: UITextField!
    @IBOutlet weak var h_home_p5: UITextField!

    @IBOutlet weak var h_guest_team: UITextField!
    @IBOutlet weak var h_guest_p1: UITextField!
    @IBOutlet weak var h_guest_p2: UITextField!
    @IBOutlet weak var h_guest_p3: UITextField!
    @IBOutlet weak var h_guest_p4: UITextField!
    @IBOutlet weak var h_guest_p5: UITextField!
    
    
    let team = ["Taipei","Taichung"]
    var team_a_player = ["test"]
   // let team_b_player = ["liu","liu2","liu3"]
    let teampick = UIPickerView()
    let playerpick = UIPickerView()
    let db = sqliteConnect()
    
    @IBAction func test(_ sender: Any) {
        
        h_home_team.inputView = teampick
        print("OKOK")
    }
    
    @IBAction func player_test(_ sender: Any) {
        h_home_p1.inputView = playerpick
    }
    
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        if pickerView == teampick {
            return 1
        }else if pickerView == playerpick {
            return 1
        }
        return 0
    }

    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return team.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       
        
        return team[row]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        teampick.delegate = self
        playerpick.delegate = self
        //db.selectplayer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
}
