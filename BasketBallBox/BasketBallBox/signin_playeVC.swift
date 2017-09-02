//
//  signin_playeVC.swift
//  BasketBallBox
//
//  Created by Jimmy on 2017/8/4.
//  Copyright © 2017年 Jimmy. All rights reserved.
//

import UIKit

class signin_playeVC: UIViewController {

    @IBOutlet weak var p_team: UITextField!
    @IBOutlet weak var p_name: UITextField!
    @IBOutlet weak var p_no: UITextField!
    
    
    @IBAction func save_player(_ sender: Any) {
        let db = sqliteConnect()
        let p_name = self.p_name.text ?? "noman"
        let p_no = self.p_no.text ?? "99"
        let p_team = self.p_team.text ?? "noteam"
        
        db.insert(table_name: "player", row_info: ["p_name":"'\(p_name)'","p_team":"'\(p_team)'","p_no":"'\(p_no)'"])
        
        cleantext()
    }
    
    func cleantext(){
        p_name.text = ""
        p_no.text = ""
    }
    
    @IBAction func gogame(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "entrymenu")
        show(vc!, sender: self)
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
