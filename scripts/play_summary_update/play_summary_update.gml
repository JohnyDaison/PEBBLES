function play_summary_update() {
    with(play_menu_window)
    {
        var stats_text = "", gamemode_text = "", place_text = "", summary_text = "";
        var place_column_start = 27;

        var gm = DB.gamemodes[? gamemode_picker.cur_item_id], place;
    
        if(!is_undefined(gm))
        {
            var min_players = gm[? "min_players"], max_players = gm[? "max_players"], max_bots = max_players - gm[? "min_real_players"], min_teams = gm[? "min_teams"];
            var world = noone, place = noone;
            var gamemode_stats_list = ds_list_create();
            var place_stats_list = ds_list_create();
            
            // PLAYERS
            var players_text = "";
            
            if(min_players != max_players) {
                players_text += string(min_players) + "-";
            }
            
            players_text += string(max_players) + " player";
            if(max_players > 1) {
                players_text += "s";
            }
        
            if(max_bots > 0) {
                players_text += ", up to " + string(max_bots) + " CPU";
            }
            
            ds_list_add(gamemode_stats_list, players_text);
            
            
            // LIMITS
            var score_limit = gmmod_controls[? "score_limit"].get_value();
            if (is_number(score_limit)) {
                var score_text = "Score to win: " + string(score_limit);
                
                ds_list_add(gamemode_stats_list, score_text);
            }
        
            // GAMEMODE DESCRIPTION
            gamemode_text += "-|Game Mode|-  " + gm[? "description"] + "\n";
        
        
            // PLACE
            if(instance_exists(play_menu_window.world))
            {
                world = play_menu_window.world;
                place = world.places[| place_picker.cur_item];
                if(!is_undefined(place))
                {
                    var max_teams = min(gm[? "max_teams"], place.max_team_count);
                    
                    // BRONZE TIME
                    if(!is_undefined(place.times[? "bronze"]))
                    {
                        var bronze_text = "Bronze time: " + seconds_to_time_str(place.times[? "bronze"]);
                        ds_list_add(place_stats_list, bronze_text);
                    }
                    
                    // TEAMS
                    var teams_text = "";
                    
                    if(min_teams != max_teams) {
                        teams_text += string(min_teams) + "-";
                    }
            
                    teams_text += string(max_teams) + " team";
                    if(max_teams > 1) {
                        teams_text += "s";
                    }
                    ds_list_add(place_stats_list, teams_text);
                                
                    // GRID SIZE
                    var grid_text = "Grid size: ";
                    grid_text += string(floor( (place.width - 2*place.margin) / 32 )) + "x" + string(floor( (place.height - 2*place.margin) / 32 ));
                    ds_list_add(place_stats_list, grid_text);
                
                    // DESCRIPTION
                    place_text += "-|Level|-  " + place.description + "\n";
                }
            }
            
            // COMBINE GAMEMODE AND PLACE STATS LISTS
            var gamemode_stats_count = ds_list_size(gamemode_stats_list);
            var place_stats_count = ds_list_size(place_stats_list);
            var count = max(gamemode_stats_count, place_stats_count);
            var line;
            
            for (var index = 0; index < count; index++) {
                line = "";
                
                if (index < gamemode_stats_count) {
                    line += gamemode_stats_list[| index];
                }
                
                while(string_length(line) < place_column_start) {
                    line += " ";
                }
                
                if (index < place_stats_count) {
                    line += place_stats_list[| index];
                }
                
                stats_text += line + "\n";
            }
            
            ds_list_destroy(gamemode_stats_list);
            ds_list_destroy(place_stats_list);
        }
        
        summary_text = stats_text + "\n" + gamemode_text + "\n" + place_text;
    
        summary_scroll_list.load_long_text(summary_text, summary_list);
    }
}
