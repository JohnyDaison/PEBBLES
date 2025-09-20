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
    
        var inst = instance_create(x,y,shield_obj);
        //inst.sprite_index = old_shield_sprite;
        inst.my_player = my_player;
        inst.overcharge = 2;
        inst.chargerate = 150;
        inst.charge = 0.5;
        inst.my_color = self.my_color; 
        inst.my_guy = inst.id;
        inst.my_source = object_index;
    }
}

last_attacker_destroy();

event_inherited();
