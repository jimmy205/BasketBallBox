//
//  combatDetail.swift
//  BasketBallBox
//
//  Created by Jimmy on 2017/7/19.
//  Copyright © 2017年 Jimmy. All rights reserved.
//

import UIKit

class combatDetail: UIViewController {
    
    
    @IBOutlet weak var teambScore: UILabel!
    @IBOutlet weak var teamaScore: UILabel!
    @IBOutlet weak var teamabtn: UIButton!
    @IBOutlet weak var teambbtn: UIButton!
    
    @IBOutlet weak var stackVie: UIStackView!
    
    // Team A detail
    @IBOutlet weak var teama1: UILabel!
    @IBOutlet weak var teama2: UILabel!
    @IBOutlet weak var teamafg: UILabel!
    @IBOutlet weak var teama3fg: UILabel!
    @IBOutlet weak var teamaft: UILabel!
    @IBOutlet weak var teamaassist: UILabel!
    @IBOutlet weak var teamareb: UILabel!
    @IBOutlet weak var teamastl: UILabel!
    @IBOutlet weak var teamablk: UILabel!
    @IBOutlet weak var teamato: UILabel!
    
    //Team B detail
    
    @IBOutlet weak var teamb1: UILabel!
    @IBOutlet weak var teamb2: UILabel!
    @IBOutlet weak var teambfg: UILabel!
    @IBOutlet weak var teamb3fg: UILabel!
    @IBOutlet weak var teambft: UILabel!
    @IBOutlet weak var teambassist: UILabel!
    @IBOutlet weak var teambreb: UILabel!
    @IBOutlet weak var teambstl: UILabel!
    @IBOutlet weak var teambblk: UILabel!
    @IBOutlet weak var teambto: UILabel!
    
    
    
    
    
    let db = sqliteConnect()
    var teama : String?
    var teamb : String?
    var game_id : String?
    var team : String?
    var team_box = [[String:String]]()
    
    @objc func showPlayerDetail(_ sender: UITapGestureRecognizer){
        self.performSegue(withIdentifier: "showGameDetail", sender: self)
    }
    
    func fingerGesture(){
        let fingerGesture = UITapGestureRecognizer(target: self, action: #selector (showPlayerDetail(_:)))
        fingerGesture.numberOfTapsRequired = 1
        fingerGesture.numberOfTouchesRequired = 1
        stackVie.addGestureRecognizer(fingerGesture)
    }
    
    
    @IBAction func showTeamAHistory(_ sender: Any) {
        team = teama1.text
        self.performSegue(withIdentifier: "show_team_history", sender: self)
    }
    
    @IBAction func showTeamBHistory(_ sender: Any) {
        team = teamb1.text
        self.performSegue(withIdentifier: "show_team_history", sender: self)
    }
    
    
    
    
    
    func setupteamname(){
        teama1.text = teama!
        teama2.text = teama!
        teamb1.text = teamb!
        teamb2.text = teamb!
        teamabtn.setTitle(teama!, for: .normal)
        teambbtn.setTitle(teamb!, for: .normal)
    }
    
    func selectgamebox(){
        let point = db.selectcompetebox()
        
        while sqlite3_step(point) == SQLITE_ROW{
            let cname = sqlite3_column_text(point, 1)
            //playerlistb += [String(cString: cname!)]
            // print(String(cString: cname!))
        }
    }
    
    
    func selectboxdetail(){
        let point = db.selectboxdetail(teamid: game_id!)
        while sqlite3_step(point) == SQLITE_ROW{
            
            let p_team = String(cString: sqlite3_column_text(point, 0))
            let tpt_made = String(cString: sqlite3_column_text(point, 1))
            let tpt_miss = String(cString: sqlite3_column_text(point, 2))
            let three_made = String(cString: sqlite3_column_text(point, 3))
            let three_miss = String(cString: sqlite3_column_text(point, 4))
            let freethrow_made = String(cString: sqlite3_column_text(point, 5))
            let freethrow_miss = String(cString: sqlite3_column_text(point, 6))
            let turnover = String(cString: sqlite3_column_text(point, 7))
            let assist = String(cString: sqlite3_column_text(point, 8))
            let block = String(cString: sqlite3_column_text(point, 9))
            let steal = String(cString: sqlite3_column_text(point, 10))
            let off_reb = String(cString: sqlite3_column_text(point, 11))
            let def_reb = String(cString: sqlite3_column_text(point, 12))
            let foul = String(cString: sqlite3_column_text(point, 13))
            
            
            team_box += [["p_name":p_team
                ,"tpt_made":tpt_made
                ,"tpt_miss":tpt_miss
                ,"threept_made":three_made
                ,"threept_miss":three_miss
                ,"ft_made":freethrow_made
                ,"ft_miss":freethrow_miss
                ,"turnover":turnover
                ,"assist":assist
                ,"block":block
                ,"steal":steal
                ,"off_reb":off_reb
                ,"def_reb":def_reb
                ,"foul":foul]]
            
            
            
            
            // playerlistb += [String(cString: cname!)]
            // print(String(cString: p_team!))
            
        }
        // let teama_box = team_box[0]
         print(team_box)
    }
    
    
    
    func settingfglabel(){
        
        if team_box.count >= 2
        {
        let teama_box = team_box[0]
        let teamb_box = team_box[1]
        
            print(teama_box)
            print(teamb_box)
            
        let afgama = Double(teama_box["tpt_made"]!)
        let afgami = Double(teama_box["tpt_miss"]!)
       
        let afga = String((afgama!/(afgama!+afgami!))*100)
        
        
        if afga == "nan"{
            teamafg.text = "0%"
        }else{
            let index = afga.index(afga.startIndex, offsetBy:2)
            teamafg.text = afga.substring(to: index) + "%"
        }
        
        
        
        let afgbma = Double(teamb_box["tpt_made"]!)
        let afgbmi = Double(teamb_box["tpt_miss"]!)
        let afgb = String((afgbma!/(afgbma!+afgbmi!))*100)

        if afgb == "nan"{
        teambfg.text = "0 %"
        }else{
            let index = afgb.index(afgb.startIndex, offsetBy:2)
         teambfg.text = afgb.substring(to: index) + "%"
        }
        }
    }
    func settingthreeptlabel(){
        let teama_box = team_box[0]
        let teamb_box = team_box[1]
        
        let atfgama = Double(teama_box["threept_made"]!)
        let atfgami = Double(teama_box["threept_miss"]!)
        let atfga = String((atfgama!/(atfgama!+atfgami!))*100)
       
        if atfga == "nan"{
            teama3fg.text =  "0 %"

        }else{
            let index = atfga.index(atfga.startIndex, offsetBy:2)
            teama3fg.text = atfga.substring(to: index) + "%"
        }
        
        let atfgbma = Double(teamb_box["threept_made"]!)
        let atfgbmi = Double(teamb_box["threept_miss"]!)
        let atfgb = String((atfgbma!/(atfgbma!+atfgbmi!))*100)

        if atfgb == "nan"{
            teamb3fg.text = "0%"
        }else{
            let index = atfgb.index(atfgb.startIndex, offsetBy:2)
            teamb3fg.text = atfgb.substring(to: index) + "%"
        }
        
        
    }
    
    func settingftlabel(){
        
        let teama_box = team_box[0]
        let teamb_box = team_box[1]
        
        let aftma = Double(teama_box["ft_made"]!)
        let aftmi = Double(teama_box["ft_miss"]!)
        let aft = String((aftma!/(aftma!+aftmi!))*100)
        if aft == "nan"{
            teamaft.text = "0 %"
        }else{
            let index = aft.index(aft.startIndex, offsetBy:2)
            teamaft.text = aft.substring(to: index) + "%"
        }
        
        
        let bftma = Double(teamb_box["ft_made"]!)
        let bftmi = Double(teamb_box["ft_miss"]!)
        let bft = String((bftma!/(bftma!+bftmi!))*100)

        if bft == "nan"{
            teambft.text = "0 %"
        }else{
            let index = bft.index(bft.startIndex, offsetBy:2)
            teambft.text = bft.substring(to: index) + "%"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showGameDetail" {
            let controller = segue.destination as! combatPlayerDetail
            let teama_box = team_box[0]
            let teamb_box = team_box[1]
            controller.teama = teama_box["p_name"]
            controller.teamb = teamb_box["p_name"]
            controller.game_id = game_id
            controller.ateam_point = teamaScore.text
            controller.bteam_point = teambScore.text
        }
        if segue.identifier == "show_team_history"{
        let controller = segue.destination as! teamHistory
       controller.team = team
        }
    }
    
    func settinglabel(){
        let teama_box = team_box[0]
        let teamb_box = team_box[1]
        
        teamaassist.text = teama_box["assist"]
        teamablk.text = teama_box["block"]
        teamato.text = teama_box["turnover"]
        teamareb.text = String(Int(teama_box["off_reb"]!)! + Int(teama_box["def_reb"]!)!)
        teamastl.text = teama_box["steal"]
        
        teambassist.text = teamb_box["assist"]
        teambblk.text = teamb_box["block"]
        teambto.text = teamb_box["turnover"]
        teambreb.text = String(Int(teamb_box["off_reb"]!)! + Int(teamb_box["def_reb"]!)!)
        teambstl.text = teamb_box["steal"]
    }
    
    func settingPoint(){
        let teama_box = team_box[0]
        let teamb_box = team_box[1]
        
        let ateam_point = Int(teama_box["ft_made"]!)!
                          + Int(Int(teama_box["threept_made"]!)!)*3
                          + Int(Int(teama_box["tpt_made"]!)!)*2
        
        teamaScore.text = String(ateam_point)
        
        let bteam_point = Int(teamb_box["ft_made"]!)!
            + Int(Int(teamb_box["threept_made"]!)!)*3
            + Int(Int(teamb_box["tpt_made"]!)!)*2
   
        teambScore.text = String(bteam_point)
        
    }
    
    @objc func back(_ sender: UITapGestureRecognizer){
        navigationController?.popViewController(animated: true)
    }
    
    func backfingerGesture(){
        let fingerGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector (back(_:)))
        fingerGesture.edges = .left
        view.addGestureRecognizer(fingerGesture)
    }

   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fingerGesture()
        setupteamname()
        selectgamebox()
        selectboxdetail()
        settingfglabel()
        settingthreeptlabel()
        settingftlabel()
        settinglabel()
        settingPoint()
        backfingerGesture()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
