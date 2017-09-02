//
//  gamerecboxvc.swift
//  BasketBallBox
//
//  Created by Jimmy on 2017/8/3.
//  Copyright © 2017年 Jimmy. All rights reserved.
//

import UIKit

class gamerecboxvc: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
    @IBOutlet weak var teamA: UILabel!
    @IBOutlet weak var teamB: UILabel!
    
    @IBOutlet weak var teamAscore: UILabel!
    
    @IBOutlet weak var teamBscore: UILabel!
    @IBOutlet weak var score: UIStackView!
    @IBOutlet weak var timenplay: UIStackView!
    @IBOutlet weak var editplayer: UIButton!
    @IBOutlet weak var donepick: UIButton!
    @IBOutlet weak var pickplayer: UIPickerView!
    @IBOutlet weak var pickplayerb: UIPickerView!
    // teamAplayer btn layout
    @IBOutlet weak var starttimer: UIButton!
    @IBOutlet weak var playerA1: UIButton!
    @IBOutlet weak var playerA2: UIButton!
    @IBOutlet weak var playerA3: UIButton!
    @IBOutlet weak var playerA4: UIButton!
    @IBOutlet weak var playerA5: UIButton!
    @IBOutlet weak var playerA6: UIButton!
    // teamBplayer btn layout
    @IBOutlet weak var playerB1: UIButton!
    @IBOutlet weak var playerB2: UIButton!
    @IBOutlet weak var playerB3: UIButton!
    @IBOutlet weak var playerB4: UIButton!
    @IBOutlet weak var playerB5: UIButton!
    @IBOutlet weak var playerB6: UIButton!
    //playername+playerdo and show on label
    @IBOutlet weak var Qtr: UILabel!
    @IBOutlet weak var Qtr_minute: UILabel!
    @IBOutlet weak var Qtr_seconed: UILabel!
    @IBOutlet weak var playername: UILabel!
    @IBOutlet weak var playerdo: UILabel!
    
    let db = sqliteConnect()
    var edit_player = true
    var buttontitle = ""
    var playerlista : [String] = []
    var playerlistb : [String] = []
    var live_scoreA = [[String:String]]()
    var live_scoreB = [[String:String]]()
    var player_foul = [[String:String]]()
    var player_four_foul = [String]()
    var player_five_foul = [String]()
    var cond1 : String?
    var cond2 : String?
    var test111 : String?
    var currentime : String?
    var game_name : String?
    var timer : Timer?
    var qtrj = 1
    var minutej = 0
    var secondj = 10
    var is_start_timer = false
    var player_do : String?
    var mademiss : String?
    var gameid : String?
    var team :String?
    // var playerlistb = ["chen","chen2","chen3","chen4","chen5"]
    
    @IBAction func donepick(_ sender: Any) {
        pickplayer.isHidden = true
        donepick.isHidden = true
        pickplayerb.isHidden = true
        timenplay.isHidden = false
        score.isHidden = false
    }
    
    @IBAction func edit_player(_ sender: Any) {
        edit_player = !edit_player
        show_edit()
    }
    
    func show_edit(){
        if edit_player == true{
            editplayer.setTitle("更換球員", for: .normal)
        }else{
            editplayer.setTitle("比賽進行中", for: .normal)
        }
    }
    
    //teamAplayer
    @IBAction func playerA1(_ sender: Any) {
        
        
        if edit_player == true{
            hidestack()
            pickplayer.isHidden = false
            donepick.isHidden = false
            playerA1.setTitle(buttontitle, for: .normal)
            
        }else{
            playername.text = playerA1.titleLabel?.text
            team = teamA.text
          //  print(team!)
        }
        
    }
    @IBAction func playerA2(_ sender: Any) {
        if edit_player == true{
            hidestack()
            pickplayer.isHidden = false
            donepick.isHidden = false
            playerA2.setTitle(buttontitle, for: .normal)
        }else{
            playername.text = playerA2.titleLabel?.text
            team = teamA.text
            print(cond1!)
        }
    }
    @IBAction func playerA3(_ sender: Any) {
        
        if edit_player == true{
            hidestack()
            pickplayer.isHidden = false
            donepick.isHidden = false
            playerA3.setTitle(buttontitle, for: .normal)
        }else{
            playername.text = playerA3.titleLabel?.text
            team = teamA.text
            print(cond1!)
        }
    }
    @IBAction func playerA4(_ sender: Any) {
        
        if edit_player == true{
            hidestack()
            pickplayer.isHidden = false
            donepick.isHidden = false
            playerA4.setTitle(buttontitle, for: .normal)
        }else{
            playername.text = playerA4.titleLabel?.text
            team = teamA.text
            print(cond1!)
        }
    }
    @IBAction func playerA5(_ sender: Any) {
        
        if edit_player == true{
            hidestack()
            pickplayer.isHidden = false
            donepick.isHidden = false
            playerA5.setTitle(buttontitle, for: .normal)
        }else{
            playername.text = playerA5.titleLabel?.text
            team = teamA.text
            print(cond1!)
        }
    }
    @IBAction func playerA6(_ sender: Any) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "show_live_detail"{
        let controller = segue.destination as! combatDetail
            controller.game_id = gameid
            controller.teama = cond1
            controller.teamb = cond2
        }
    }
    
    //teamBplayer
    @IBAction func playerB1(_ sender: Any) {
        
        
        if edit_player == true{
            hidestack()
            pickplayerb.isHidden = false
            donepick.isHidden = false
            playerB1.setTitle(buttontitle, for: .normal)
        }else{
            playername.text = playerB1.titleLabel?.text
            team = teamB.text
        }
    }
    @IBAction func playerB2(_ sender: Any) {
        if edit_player == true{
            hidestack()
            pickplayerb.isHidden = false
            donepick.isHidden = false
            playerB2.setTitle(buttontitle, for: .normal)
        }else{
            playername.text = playerB2.titleLabel?.text
            team = teamB.text
            //print(cond2!)
        }
    }
    @IBAction func playerB3(_ sender: Any) {
        
        
        if edit_player == true{
            hidestack()
            pickplayerb.isHidden = false
            donepick.isHidden = false
            playerB3.setTitle(buttontitle, for: .normal)
        }else{
            playername.text = playerB3.titleLabel?.text
            team = teamB.text
           // print(cond2!)
        }
    }
    @IBAction func playerB4(_ sender: Any) {
        
        
        if edit_player == true{
            hidestack()
            pickplayerb.isHidden = false
            donepick.isHidden = false
            playerB4.setTitle(buttontitle, for: .normal)
        }else{
            playername.text = playerB4.titleLabel?.text
            team = teamB.text
            //print(cond2!)
        }
        
    }
    @IBAction func playerB5(_ sender: Any) {
        
        
        if edit_player == true{
            hidestack()
            pickplayerb.isHidden = false
            donepick.isHidden = false
            playerB5.setTitle(buttontitle, for: .normal)
        }else{
            playername.text = playerB5.titleLabel?.text
           team = teamB.text
           // print(cond2!)
        }
    }
    @IBAction func playerB6(_ sender: Any) {
       self.performSegue(withIdentifier: "show_live_detail", sender: self)
    }
    
    //player do
    @IBAction func tpt_made(_ sender: Any) {
        playerdo.text = "2分球—進"
        player_do = "tow_pt_made"
        mademiss = "1"
    }
    
    @IBAction func tpt_miss(_ sender: Any) {
        playerdo.text = "兩分—沒進"
        player_do = "tow_pt_miss"
        mademiss = "1"
    }
    @IBAction func three_made(_ sender: Any) {
        playerdo.text = "3分球—進"
        player_do = "three_pt_made"
        mademiss = "1"
    }
    @IBAction func three_miss(_ sender: Any) {
        playerdo.text = "3分—沒進"
        player_do = "three_pt_miss"
        mademiss = "1"
    }
    @IBAction func ft_made(_ sender: Any) {
        playerdo.text = "罰球—進"
        player_do = "freethrow_made"
        mademiss = "1"
        
    }
    @IBAction func ft_miss(_ sender: Any) {
        playerdo.text = "罰球—沒進"
        player_do = "freethrow_miss"
        mademiss = "1"
    }
    @IBAction func off_reb(_ sender: Any) {
        playerdo.text = "進攻籃板"
        player_do = "off_reb"
        mademiss = "1"
    }
    @IBAction func def_reb(_ sender: Any) {
        playerdo.text = "防守籃板"
        player_do = "def_reb"
        mademiss = "1"
    }
    @IBAction func blk(_ sender: Any) {
        playerdo.text = "封阻"
        player_do = "block"
        mademiss = "1"
    }
    @IBAction func stl(_ sender: Any) {
        playerdo.text = "抄截"
        player_do = "steal"
        mademiss = "1"
    }
    @IBAction func to(_ sender: Any) {
        playerdo.text = "失誤"
        player_do = "turnover"
        mademiss = "1"
    }
    @IBAction func foul(_ sender: Any) {
        playerdo.text = "犯規"
        player_do = "foul"
        mademiss = "1"
    }
    
    @IBAction func countdowntimer(_ sender: Any) {
        
        is_start_timer = !is_start_timer
        
        if is_start_timer == true{
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {(timer) in
                self.counttime()
                self.showcount()
                self.starttimer.setTitle("比賽進行中", for: .normal)
                print(String(self.secondj))
                print(String(self.minutej))
                
            })
        }else if is_start_timer == false{
            
            timer?.invalidate()
            self.starttimer.setTitle("開始比賽", for: .normal)
        }
        
    }
    
    @IBAction func confirmInsert(_ sender: Any) {
        
       
        if edit_player == false {
        db.insert(table_name: "game_box", row_info: ["competition_id":"'\(gameid!)'","p_name":"'\(playername.text!)'","which_qtr":"'\(Qtr.text!)'","\(player_do!)":"'\(mademiss!)'","p_team":"'\(team!)'"])
        
       
        get_live_Ascore()
        set_live_Ascore()
        get_live_Bscore()
        set_live_Bscore()
        get_player_foul()
        check_player_foul()
        change_foul_player()
        }else{
            print("editplayer")
        }
    }
    
    func set_live_Ascore(){
        
        if live_scoreA.count > 0{
        let live_score_teamA = live_scoreA[0]
   
        let point_teama = Int(live_score_teamA["tow_point"]!)!
            + Int(live_score_teamA["three_point"]!)!
            + Int(live_score_teamA["free_point"]!)!
        
        if point_teama == 0 {
            teamAscore.text = "0"
        }else{
        teamAscore.text = String(point_teama)
        }
        
            if Int(live_score_teamA["foul"]!)! >= 4{
                teamA.textColor = UIColor.black
                teamA.backgroundColor = UIColor.red
            }

        print(live_scoreA.count)
        }
    }
    
    func set_live_Bscore(){
        
        if live_scoreB.count > 0{
            let live_score_teamB = live_scoreB[0]
            
            
            
            let point_teamb = Int(live_score_teamB["tow_point"]!)!
                + Int(live_score_teamB["three_point"]!)!
                + Int(live_score_teamB["free_point"]!)!
            
            if point_teamb == 0 {
                teamBscore.text = "0"
            }else{
                teamBscore.text = String(point_teamb)
            }
            
            print(live_scoreA.count)
        }else{
            print("XX")
        }
    }
    
    func select_player_foul(){
        
    }

    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        if pickerView == pickplayer{
            return playerlista.count
        }else if pickerView == pickplayerb{
            return playerlistb.count
        }
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == pickplayer{
            return playerlista[row]
        }else if pickerView == pickplayerb{
            return playerlistb[row]
        }
        
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == pickplayer{
            buttontitle = playerlista[row]
        }else if pickerView == pickplayerb{
            buttontitle = playerlistb[row]
        }
        
    }
    
    func creatplayerlista(cond1:String){
        let point = db.selectplayera(con1: cond1 )
        playerlista = []
        while sqlite3_step(point) == SQLITE_ROW{
            let cname = sqlite3_column_text(point, 1)
            playerlista += [String(cString: cname!)]
            
        }
        print(playerlista)
    }
    
    func creatplayerlistb(cond2:String){
        let point = db.selectplayerb(con2: cond2 )
        playerlistb = []
        while sqlite3_step(point) == SQLITE_ROW{
            let cname = sqlite3_column_text(point, 1)
            playerlistb += [String(cString: cname!)]
            // print(playerlista)
        }
        print(playerlistb)
    }
    
    func creatgame(){
        db.insert(table_name: "team_competition", row_info: ["teamA":"'\(cond1!)'","teamB":"'\(cond2!)'","game_name":"'\(game_name!)'","game_time":"'\(currentime!)'"])
    }
    
    func showcount(){
        Qtr_seconed.text = String(secondj)
        Qtr_minute.text = String(minutej)
        Qtr.text = "\(String(qtrj))QTR"
    }
    
    func counttime(){
        //  self.sec -= 1
        if secondj < 0 {
            minutej -= 1
            secondj = 59
            
        }else if (minutej == 0 && secondj == 0){
            timer?.invalidate()
            self.starttimer.setTitle("Start", for: .normal)
            is_start_timer = false
            minutej = 10
            secondj = 0
            qtrj += 1
            showcount()
        }else{
            secondj -= 1
        }
    }
    func hidestack(){
        timenplay.isHidden = true
        score.isHidden = true
    }
    
    func getid(){
        let point = db.selectid(game_time: currentime!)
        while sqlite3_step(point) == SQLITE_ROW{
            let id = sqlite3_column_text(point, 0)
            gameid = String(cString: id!)
            // print(String(cString: id!))
        }
    }
    
    func get_live_Ascore(){
        let point = db.select_live_score(game_id: gameid!,team: cond1)
        live_scoreA = [[String:String]]()
        while sqlite3_step(point) == SQLITE_ROW{
            let tow_point = String(cString: sqlite3_column_text(point, 2))
            let three_point = String(cString: sqlite3_column_text(point, 3))
            let free_point = String(cString: sqlite3_column_text(point, 4))
            let team_foul = String(cString: sqlite3_column_text(point, 5))
            
            live_scoreA += [["tow_point":tow_point,"three_point":three_point,"free_point":free_point,"foul":team_foul]]
        }
        print(live_scoreA)
    }
    
    func get_live_Bscore(){
        let point = db.select_live_score(game_id: gameid!,team: cond2)
        live_scoreB = [[String:String]]()
        while sqlite3_step(point) == SQLITE_ROW{
            let tow_point = String(cString: sqlite3_column_text(point, 2))
            let three_point = String(cString: sqlite3_column_text(point, 3))
            let free_point = String(cString: sqlite3_column_text(point, 4))
            let team_foul = String(cString: sqlite3_column_text(point, 5))
            
            live_scoreB += [["tow_point":tow_point,"three_point":three_point,"free_point":free_point,"foul":team_foul]]
        }
        print(live_scoreB)
    }
    
    func get_player_foul(){
        let point = db.select_player_foul(game_id: gameid!)
        player_foul = [[String:String]]()
        while sqlite3_step(point) == SQLITE_ROW{
            
            let p_name = String(cString: sqlite3_column_text(point, 0))
            
            let foul = String(cString: sqlite3_column_text(point, 1))
            
            player_foul += [["player":p_name,"foul":foul]]
        }
        print(player_foul)
    }
    
    func check_player_foul(){
        
        player_four_foul = [String]()
        player_five_foul = [String]()
        
        for i in 0..<player_foul.count
            {
            let playerfoul = player_foul[i]
                if Int(playerfoul["foul"]!)! > 3 {
                    let player = playerfoul["player"]
                     player_four_foul += [player!]
                }
                if Int(playerfoul["foul"]!)! > 4 {
                    let player = playerfoul["player"]
                    player_five_foul += [player!]
                }
        }
    }
    
    func change_foul_player(){
        
        if player_four_foul.contains((playerA1.titleLabel?.text!)!){
            playerA1.setTitleColor(UIColor.red, for: .normal)
            playerA1.backgroundColor = UIColor.red
//            if player_five_foul.contains((playerA1.titleLabel?.text!)!){
//               
//            }
        }
        
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
        pickplayer.isHidden = true
        pickplayerb.isHidden = true
        donepick.isHidden = true
        pickplayerb.delegate = self
        pickplayer.delegate = self
        creatplayerlista(cond1: cond1!)
        sleep(1)
        creatplayerlistb(cond2: cond2!)
        creatgame()
        getid()
        teamA.text = cond1!
        teamB.text = cond2!
        fingerGesture()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}
