//
//  ViewController.swift
//  BasketBallBox
//
//  Created by Jimmy on 2017/7/18.
//  Copyright © 2017年 Jimmy. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var TableView: UITableView!
    
    var myTeamCombat = ["123"]
    var team_compete = [[String:String]]()
    var teama : String?
    var teamb : String?
    //var game_time : String?
    var game_id : String?
    let db = sqliteConnect()
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        //return myTeamCombat.count
        return  team_compete.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.textColor = UIColor.white
        cell?.backgroundColor = UIColor.black
        let teamcompete = self.team_compete[indexPath.row]
    
        cell?.textLabel?.text = "\(teamcompete["game_name"]!)      \(teamcompete["game_time"]!)"
        return cell!
    }
    
    func getteamcompete(){
        
        let point = db.selectteamcompete()
        while sqlite3_step(point) == SQLITE_ROW{
            
            
            let game_id = sqlite3_column_text(point, 0)
            let team_a = sqlite3_column_text(point, 1)
            let team_b = sqlite3_column_text(point, 2)
            let game_name = sqlite3_column_text(point, 3)
            let game_time = sqlite3_column_text(point, 4)
            //myTeamCombat += [String(cString: game_name!)]
            
            team_compete += [["game_name":String(cString: game_name!)
                ,"game_id":String(cString: game_id!)
                ,"team_a":String(cString:team_a!)
                ,"team_b":String(cString:team_b!)
                ,"game_time":String(cString:game_time!)]]
        }
        // print(team_compete)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCombatDetail" {
            if let indexPath = self.TableView.indexPathForSelectedRow{
                
                let teamcompete = self.team_compete[indexPath.row]
                let controller = segue.destination as! combatDetail
                
                controller.game_id = teamcompete["game_id"]
                controller.teama = teamcompete["team_a"]
                controller.teamb = teamcompete["team_b"]
                
            }
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
        getteamcompete()
        fingerGesture()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

