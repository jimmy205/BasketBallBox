//
//  sqliteConnect.swift
//  BasketBallBox
//
//  Created by Jimmy on 2017/8/3.
//  Copyright © 2017年 Jimmy. All rights reserved.
//

import UIKit

class sqliteConnect {
    
    let appMain = UIApplication.shared.delegate as! AppDelegate
    
    // insert
    func insert(table_name:String,row_info:[String:String]){
        
        let sql = "insert into \(table_name)" +
            "(\(row_info.keys.joined(separator: ",")))" +
        "values (\(row_info.values.joined(separator: ",")))"
        var point:OpaquePointer?
        
        if sqlite3_prepare_v2(appMain.db, sql, -1, &point, nil) == SQLITE_OK{
            if sqlite3_step(point) == SQLITE_DONE{
                print("OK")
            }
        }
        print(sql)
    }
    
    //    func insert2(){
    //
    //        let sql = "insert into test343 (p_test) values ('123')"
    //        var point:OpaquePointer?
    //
    //        if sqlite3_prepare_v2(appMain.db, sql, -1, &point, nil) == SQLITE_OK{
    //            if sqlite3_step(point) == SQLITE_DONE{
    //                print("OK")
    //            }
    //        }
    //        print(sql)
    //    }
    
    //selectplayer
    func selectplayera(con1:String) -> OpaquePointer{
        
        let sql = "select * from player where p_team = '\(con1)'"
        var point : OpaquePointer?
        if sqlite3_prepare(appMain.db, sql, -1, &point, nil) == SQLITE_OK{
            print("ok")
        }else{
            print(sql)
            print("xx")
        }
        
        return point!
    }
    
    func selectplayerb(con2:String) -> OpaquePointer{
        let sql = "select * from player where p_team = '\(con2)'"
        var point : OpaquePointer?
        if sqlite3_prepare(appMain.db, sql, -1, &point, nil) == SQLITE_OK{
            print("ok")
        }else{
            print("xx")
        }
        return point!
    }
    
    func creat_player(){
        let sql1 = "create table if not exists player"
            + "( id integer primary key autoincrement, "
            + "p_name text default x, p_no int default 0,p_team text default x)"
        
        if sqlite3_exec(appMain.db, sql1, nil, nil, nil) == SQLITE_OK{
            print("Player建立資料表成功")
        }
    }
    
    func selectid(game_time:String) -> OpaquePointer{
        let sql = "select * from team_competition where game_time = '\(game_time)'"
        var point : OpaquePointer?
        if sqlite3_prepare(appMain.db, sql, -1, &point, nil) == SQLITE_OK{
            print("ok")
        }else{
            print(sql)
            print("xx")
        }
        return point!
    }
    
    func selectteamcompete() -> OpaquePointer{
        let sql = "select * from team_competition order by id desc"
        var point : OpaquePointer?
        if sqlite3_prepare(appMain.db, sql, -1, &point, nil) == SQLITE_OK{
            print("ok")
        }else{
            print(sql)
            print("xx")
        }
        return point!
    }
    
    func selectcompetebox() -> OpaquePointer{
        let sql = "select * from game_box"
        var point : OpaquePointer?
        if sqlite3_prepare(appMain.db, sql, -1, &point, nil) == SQLITE_OK{
            print("ok")
        }else{
            print(sql)
            print("xx")
        }
        return point!
    }
    
    func selectboxdetail(teamid:String?) -> OpaquePointer{
        let sql = "select p_team,sum(tow_pt_made),sum(tow_pt_miss),sum(three_pt_made),sum(three_pt_miss),sum(freethrow_made),sum(freethrow_miss),sum(turnover),sum(assist),sum(block),sum(steal),sum(off_reb),sum(def_reb),sum(foul) from game_box where competition_id = '\(teamid!)' group by p_team"
        var point : OpaquePointer?
        if sqlite3_prepare(appMain.db, sql, -1, &point, nil) == SQLITE_OK{
            print("ok")
          //  print(sql)
        }else{
            print(sql)
            print("xx")
        }
        return point!
    }
    
    func select_game_player_detaile(game_id:String?,team:String?) -> OpaquePointer{
        let sql = "select p_name,sum(tow_pt_made),sum(tow_pt_miss),sum(three_pt_made),sum(three_pt_miss),sum(freethrow_made),sum(freethrow_miss),sum(turnover),sum(assist),sum(block),sum(steal),sum(off_reb),sum(def_reb),sum(foul) from game_box where competition_id = \(game_id!) and p_team = '\(team!)' group by p_name"
        var point : OpaquePointer?
        if sqlite3_prepare(appMain.db, sql, -1, &point, nil) == SQLITE_OK{
            print("OK")
           // print(sql)
        }else{
            print(sql)
            print("NO")
        }
        return point!
    }
    
    func select_player_history(player_name:String?) -> OpaquePointer{
        
        let sql = "select p_name,sum(tow_pt_made),sum(tow_pt_miss),sum(three_pt_made),sum(three_pt_miss),sum(freethrow_made),sum(freethrow_miss),sum(turnover),sum(assist),sum(block),sum(steal),sum(off_reb),sum(def_reb),sum(foul) from game_box where p_name = '\(player_name!)' group by p_name"
        var point : OpaquePointer?
        if sqlite3_prepare(appMain.db, sql, -1, &point, nil) == SQLITE_OK{
            print("OK")
             print(sql)
        }else{
            print(sql)
            print("NO")
        }
        return point!
    }
    
    func select_team_history(team_name:String?) -> OpaquePointer{
        
        let sql = "select p_team,sum(tow_pt_made),sum(tow_pt_miss),sum(three_pt_made),sum(three_pt_miss),sum(freethrow_made),sum(freethrow_miss),sum(turnover),sum(assist),sum(block),sum(steal),sum(off_reb),sum(def_reb),sum(foul) from game_box where p_team = '\(team_name!)' group by p_team"
        var point : OpaquePointer?
        if sqlite3_prepare(appMain.db, sql, -1, &point, nil) == SQLITE_OK{
            print("OK")
           // print(sql)
        }else{
            print(sql)
            print("NO")
        }
        return point!
    }
    
    func select_live_score(game_id:String?,team:String?) -> OpaquePointer{
        let sql = "select p_team,p_name,sum(tow_pt_made)*2 as tp,sum(three_pt_made)*3 as three,sum(freethrow_made),sum(foul) from game_box where competition_id = \(game_id!) and p_team = '\(team!)' group by p_team;"
        var point : OpaquePointer?
        if sqlite3_prepare(appMain.db, sql, -1, &point, nil) == SQLITE_OK{
            print("OK")
        }else{
            print("NO")
            print(sql)
        }
        return point!
    }
    
    func select_player_foul(game_id:String?) -> OpaquePointer{
        let sql = "select p_name,sum(foul) from game_box where competition_id = \(game_id!) group by p_name;"
        var point : OpaquePointer?
        if sqlite3_prepare(appMain.db, sql, -1, &point, nil) == SQLITE_OK{
            print("OK")
        }else{
            print("NO")
            print(sql)
        }
        return point!
    }
    
    func count_point(game_id:String?) -> OpaquePointer{
        let sql = "select p_team,which_qtr,sum(tow_pt_made)*2 as fg, sum(three_pt_made) as three,sum(freethrow_made) as free from game_box group by which_qtr;"
        var point : OpaquePointer?

        if sqlite3_prepare(appMain.db, sql, -1, &point, nil) == SQLITE_OK{
            print("OK")
            print(sql)
        }else{
            print(sql)
            print("NO")
        }
        return point!

    }
    
    func select_team() -> OpaquePointer{
        let sql = "select distinct(p_team) from player"
        
        var point : OpaquePointer?
        
        if sqlite3_prepare(appMain.db, sql, -1, &point, nil) == SQLITE_OK{
            print("OK")
            print(sql)
        }else{
            print(sql)
            print("NO")
        }
        return point!


    }
    
    
    
    func creat_team_competition (){
        let sql2 = "create table if not exists team_competition"
            + "( id integer primary key autoincrement, "
            + "teamA text default x, teamB text default x,game_name text default x,game_time text default x)"
        
        if sqlite3_exec(appMain.db, sql2, nil, nil, nil) == SQLITE_OK{
            print("team_cmp建立資料表成功")
        }
    }
    
    func creat_game_box() {
        let sql3 = "create table if not exists game_box"
            + "( id integer primary key autoincrement, competition_id int,"
            + "p_team text default x,p_name text default x,"
            + "which_qtr int default x,tow_pt_made int default 0,"
            + "tow_pt_miss int default 0,three_pt_made int default 0,"
            + "three_pt_miss int default 0, freethrow_made int default 0,"
            + "freethrow_miss int default 0,turnover int default 0,"
            + "assist int default 0, block int default 0, steal int default 0,"
        + "off_reb int default 0,def_reb int default 0,foul int default 0)"
        
        if sqlite3_exec(appMain.db, sql3, nil, nil, nil) == SQLITE_OK{
            print("game_box建立資料表成功")
        }
        
    }
    func creat_test1() {
        let sql3 = "create table if not exists test343"
            + "( id integer primary key autoincrement,p_team CHAR(255) default 'x',p_test text default x)"
        
        
        if sqlite3_exec(appMain.db, sql3, nil, nil, nil) == SQLITE_OK{
            print("game_box建立資料表成功")
        }
        
    }
    
}
