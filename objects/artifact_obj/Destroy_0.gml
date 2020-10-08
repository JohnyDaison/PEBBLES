if(!cancelled)
{
    var la_player = last_attacker_map[? "player"];
    var what = last_attacker_map[? "source"];

    if(instance_exists(la_player))
    {
        var score_value = gamemode_obj.score_values[? "artifact_destroyed"];
        increase_stat(la_player, "artifacts_destroyed", 1, false);
    
        increase_stat(la_player, "score", score_value, false);
    
        if(la_player != gamemode_obj.environment || what != noone)
        {
            battlefeed_post_destruction(id, id.last_attacker_map, stat_label("score", score_value, "+"));
        }
    
        gamemode_obj.stats[? "artifacts_destroyed_total"] += 1;
    
        my_sound_play_colored(shot_bounce_sound, my_color, true);
    
        i = instance_create(x,y,shield_obj);
        //i.sprite_index = old_shield_sprite;
        i.my_player = my_player;
        i.overcharge = 2;
        i.chargerate = 150;
        i.charge = 0.5;
        i.my_color = self.my_color; 
        i.my_guy = i.id;
        i.my_source = object_index;
    }
}

last_attacker_destroy();

event_inherited();
