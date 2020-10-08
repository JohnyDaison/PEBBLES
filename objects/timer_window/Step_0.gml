/*
if(debug_mode)
{
    show_debug_message("Timer window step");
}
*/
if(!gamemode_obj.match_finished)
{
    if(instance_exists(time))
    {
        /*
        if(debug_mode)
        {
            show_debug_message("time exists");
        }
        */
        
        time.time_limit = gamemode_obj.time_limit;
        raw_total += delta_time/1000000; //(current_time - last_check)/1000;
        time.total = floor(raw_total);
        last_check = current_time;
        visible = true;
        time.visible = true;
        
        //show_medal = floor((singleton_obj.step_count mod 120)/60);
        
        var times = gamemode_obj.world.current_place.times;
        var time_key = ds_map_find_first(times), time_value;
        
        if(best_time_award != "")
        {
            if(time.total > best_award_value)
            {
                best_award_value = -1;
                best_time_award = "";
            }
        }
        
        if(best_time_award == "")
        {
            while(!is_undefined(time_key))
            {
                time_value = times[? time_key];
                if((best_award_value == -1 || best_award_value > time_value) && time.total <= time_value)
                {
                    best_award_value = time_value;
                    best_time_award = time_key;
                }
            
                time_key = ds_map_find_next(times, time_key);
            }
        }
        
        self.show_medal = (best_time_award != "" && best_time_award != "normal");
        /*
        if(debug_mode)
        {
            show_debug_message("show medal");
        }
        */
        
        if(self.show_medal)
        {
            if(!medal_label.visible)
            {
                self.width = 120;
                medal_label.visible = true;
                time.x = x + 48;
            }
            
            if(medal_label.visible)
            {
                switch(best_time_award)
                {
                    case "gold":
                        medal_label.icon = gold_medal_spr;
                        break;
                    case "silver":
                        medal_label.icon = silver_medal_spr;
                        break;
                    case "bronze":
                        medal_label.icon = bronze_medal_spr;
                        break;
                }
            }
        }
        else
        {
            if(medal_label.visible)
            {
                self.width = 80;
                medal_label.visible = false;
                time.x = x + 8;
            }
        }
    }
}

/*
if(debug_mode)
{
    show_debug_message("Timer windows step finished");
    show_debug_message("paused: "+ string(singleton_obj.paused) + " has_unpaused: "+ string(singleton_obj.has_unpaused));
}
*/

