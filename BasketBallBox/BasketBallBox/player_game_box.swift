//
//  player_game_box.swift
//  BasketBallBox
//
//  Created by Jimmy on 2017/8/10.
//  Copyright © 2017年 Jimmy. All rights reserved.
//

import UIKit

class player_game_box: UITableViewCell {

   
    @IBOutlet weak var player_name: UILabel!
    
    @IBOutlet weak var player_point: UILabel!
    
    @IBOutlet weak var player_two_made: UILabel!
    
    @IBOutlet weak var player_two_total: UILabel!
    
    @IBOutlet weak var player_three_made: UILabel!
    
    @IBOutlet weak var player_three_total: UILabel!
    
    @IBOutlet weak var player_ft_made: UILabel!
    
    @IBOutlet weak var player_ft_total: UILabel!
    
    @IBOutlet weak var player_reb: UILabel!
    
    @IBOutlet weak var player_assist: UILabel!
    
    @IBOutlet weak var player_steal: UILabel!
    
    @IBOutlet weak var player_block: UILabel!
    
    @IBOutlet weak var player_turn_over: UILabel!
    
    
    @IBOutlet weak var player_def_reb: UILabel!
    @IBOutlet weak var player_off_reb: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
