//
//  teamHistory.swift
//  BasketBallBox
//
//  Created by Jimmy on 2017/8/11.
//  Copyright © 2017年 Jimmy. All rights reserved.
//

import UIKit

class teamHistory: UIViewController {

    @IBOutlet weak var teamHistory: UILabel!
    @IBOutlet weak var total_point: UILabel!
    @IBOutlet weak var fg: UILabel!
    @IBOutlet weak var threepointer: UILabel!
    @IBOutlet weak var ft: UILabel!
    @IBOutlet weak var assist: UILabel!
    @IBOutlet weak var reb: UILabel!
    @IBOutlet weak var steal: UILabel!
    @IBOutlet weak var block: UILabel!
    
    var team:String?
    let db = sqliteConnect()
    var team_history = [[String:String]]()
    
    
//    @IBAction func testbtn(_ sender: Any) {
//       navigationController?.popViewController(animated: true)
//    }
    
    
    
    func select_team_history(){
        let point = db.select_team_history(team_name: team)
        
        while sqlite3_step(point) == SQLITE_ROW{
       
            let team_name = String(cString:sqlite3_column_text(point, 0))
            let tpt_made = String(cString:sqlite3_column_text(point, 1))
            let tpt_miss = String(cString:sqlite3_column_text(point, 2))
            let three_made = String(cString:sqlite3_column_text(point, 3))
            let three_miss = String(cString:sqlite3_column_text(point, 4))
            let freethrow_made = String(cString:sqlite3_column_text(point, 5))
            let freethrow_miss = String(cString:sqlite3_column_text(point, 6))
            let turnover = String(cString:sqlite3_column_text(point, 7))
            let assist = String(cString:sqlite3_column_text(point, 8))
            let block = String(cString:sqlite3_column_text(point, 9))
            let steal = String(cString:sqlite3_column_text(point, 10))
            let off_reb = String(cString:sqlite3_column_text(point, 11))
            let def_reb = String(cString:sqlite3_column_text(point, 12))
            
            let total_tpt = Int(tpt_made)! + Int(tpt_miss)!
            let total_reb = Int(off_reb)! + Int(def_reb)!
            let total_three = Int(three_made)! + Int(three_miss)!
            let total_ft = Int(freethrow_made)! + Int(freethrow_miss)!
            
            team_history += [["team_name":team_name
                ,"p_two_made":tpt_made
                ,"p_two_total":String(total_tpt)
                ,"p_three_made":three_made
                ,"p_three_total":String(total_three)
                ,"p_ft_made":freethrow_made
                ,"p_ft_total":String(total_ft)
                ,"p_reb":String(total_reb)
                ,"p_off_reb":off_reb
                ,"p_def_reb":def_reb
                ,"p_ast":assist
                ,"p_stl":steal
                ,"p_blk":block
                ,"p_to":turnover
                ]]
            //print(name)
        }
        
        print(team_history)
        
    }
    
    func settinlabel(){
        let teamhistory = self.team_history[0]
        
        let ft_made = Double(teamhistory["p_two_made"]!)
        let ft_total = Double(teamhistory["p_two_total"]!)
        
        let three_made = Double(teamhistory["p_three_made"]!)
        let three_total = Double(teamhistory["p_three_total"]!)
        
        let free_made = Double(teamhistory["p_ft_made"]!)
        let free_total = Double(teamhistory["p_ft_total"]!)
        
        let total_po = Int(teamhistory["p_two_made"]!)!*2 + Int(teamhistory["p_three_made"]!)!*3 +
            Int(teamhistory["p_ft_made"]!)!
        
        let ft_percent = String((ft_made! / ft_total!)*100)
        let three = String((three_made! / three_total!)*100)
        let free = String((free_made! / free_total!)*100)
        
        
        
       total_point.text = String(total_po)
        
        if ft_percent == "nan" {
            fg.text = "0 %"
        }else{
            let index = ft_percent.index(ft_percent.startIndex, offsetBy:2)
            fg.text =  "\(ft_percent.substring(to: index)) %   (\(teamhistory["p_two_made"]!) / \(teamhistory["p_two_total"]!))"
            
        }
        
        if three == "nan" {
            threepointer.text = "0 %"
        }else{
            let index = three.index(three.startIndex, offsetBy:2)
            threepointer.text = "\(three.substring(to: index)) %  （\(teamhistory["p_three_made"]!) / \(teamhistory["p_three_total"]!)）"
        }
        
        if free == "nan"{
            ft.text = "0 %"
        }else{
            let index = free.index(free.startIndex, offsetBy:2)
            ft.text = "\(free.substring(to: index)) %  （\(teamhistory["p_ft_made"]!) / \(teamhistory["p_ft_total"]!)）"
        }
        
        
        
        assist.text = teamhistory["p_ast"]
        block.text = teamhistory["p_blk"]
        reb.text = teamhistory["p_reb"]
        steal.text = teamhistory["p_stl"]
        
    }
    @objc func showPlayerDetail(_ sender: UITapGestureRecognizer){
        navigationController?.popViewController(animated: true)
    }
    
    func fingerGesture(){
        let fingerGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector (showPlayerDetail(_:)))
        fingerGesture.edges = .left
        view.addGestureRecognizer(fingerGesture)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        select_team_history()
        settinlabel()
        fingerGesture()
        teamHistory.text = "\(team!) 的歷史比賽數據"
       // print(team)
        // Do any additional setup after loading the view.
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
