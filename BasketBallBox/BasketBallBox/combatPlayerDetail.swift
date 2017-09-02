//
//  combatPlayerDetail.swift
//  BasketBallBox
//
//  Created by Jimmy on 2017/7/19.
//  Copyright © 2017年 Jimmy. All rights reserved.
//

import UIKit

class combatPlayerDetail: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    
    
    @IBOutlet weak var bteam_score: UILabel!
    @IBOutlet weak var ateam_score: UILabel!
    @IBOutlet weak var changeTeam: UISegmentedControl!
    @IBOutlet weak var tableview: UITableView!
    
    
    var teamPlayer = [["p_name":"姓名","p_point":"得分","p_two_made":"兩分進","p_two_total":"兩分出手","p_three_made":"三分進","p_three_total":"三分出手","p_ft_made":"罰球進","p_ft_total":"罰球出手","p_reb":"總籃板數","p_off_reb":"進攻藍板","p_def_reb":"防守籃板","p_ast":"助攻","p_stl":"抄截","p_blk":"阻攻","p_to":"失誤"]]
    private let playerBox = ["123","123","123","player5","player32"]
    let db = sqliteConnect()
    var teama : String?
    var teamb : String?
    var game_id : String?
    var team = true
    var ateam_point : String?
    var bteam_point : String?
    
    @IBAction func changeTeam(_ sender: Any) {
        
        team = !team
    
        if team == true{
        getteamaplayer(game_id: game_id!, team: teama!)
            self.tableview.reloadData()
        }else if team == false{
        getteamaplayer(game_id: game_id!, team: teamb!)
            self.tableview.reloadData()
        }
    }
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        //let teamPlayer = teamPlayer[IndexPath.row]
        return teamPlayer.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let teamplayer = teamPlayer[indexPath.row]
        let cell = tableview.dequeueReusableCell(withIdentifier: "player_game_box") as! player_game_box
        
       cell.backgroundColor = UIColor.black
        cell.player_name.text = teamplayer["p_name"]
        cell.player_point.text = teamplayer["p_point"]
        cell.player_two_made.text = teamplayer["p_two_made"]
        cell.player_two_total.text = teamplayer["p_two_total"]
        cell.player_three_made.text = teamplayer["p_three_made"]
        cell.player_three_total.text = teamplayer["p_three_total"]
        cell.player_ft_made.text = teamplayer["p_ft_made"]
        cell.player_ft_total.text = teamplayer["p_ft_total"]
        cell.player_reb.text = teamplayer["p_reb"]
        cell.player_off_reb.text = teamplayer["p_off_reb"]
        cell.player_def_reb.text = teamplayer["p_def_reb"]
        cell.player_assist.text = teamplayer["p_ast"]
        cell.player_steal.text = teamplayer["p_stl"]
        cell.player_block.text = teamplayer["p_blk"]
        cell.player_turn_over.text = teamplayer["p_to"]
        
        return cell
    }
    func getteamaplayer(game_id:String,team:String){
        let point = db.select_game_player_detaile(game_id: game_id, team:team)
        teamPlayer = [["p_name":"姓名","p_point":"得分","p_two_made":"兩分進","p_two_total":"兩分出手","p_three_made":"三分進","p_three_total":"三分出手","p_ft_made":"罰球進","p_ft_total":"罰球出手","p_reb":"總籃板數","p_off_reb":"進攻藍板","p_def_reb":"防守籃板","p_ast":"助攻","p_stl":"抄截","p_blk":"阻攻","p_to":"失誤"]]
        while sqlite3_step(point) == SQLITE_ROW{
            
            let p_name = String(cString:sqlite3_column_text(point, 0))
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
            
            
            let point = (Int(three_made)! * 3 ) + (Int(tpt_made)! * 2) + Int(freethrow_made)!
            let total_reb = Int(def_reb)! + Int(off_reb)!
            let total_tpt = Int(tpt_made)! + Int(tpt_miss)!
            let total_three = Int(three_made)! + Int(three_miss)!
            let total_ft = Int(freethrow_made)! + Int(freethrow_miss)!
            
            teamPlayer += [["p_name":p_name
                ,"p_point":String(point)
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
            
            
        }
        // print(teamPlayer)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "show_player_history" {
            if let indexPath = self.tableview.indexPathForSelectedRow{
                
                let teamplayer = self.teamPlayer[indexPath.row]
                let controller = segue.destination as! playerHistory
                
                controller.player_name = teamplayer["p_name"]
                
            }        }
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
        fingerGesture()
        getteamaplayer(game_id: game_id!, team: teama!)
        changeTeam.setTitle(teama!, forSegmentAt: 0)
        changeTeam.setTitle(teamb!, forSegmentAt: 1)
       tableview.backgroundColor = UIColor.black
        ateam_score.text = ateam_point!
        bteam_score.text = bteam_point!
    // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
