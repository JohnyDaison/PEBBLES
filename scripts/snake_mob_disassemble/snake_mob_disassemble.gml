function snake_mob_disassemble(index) {
    var i, ter, trophy, living_head = noone;

    index = clamp(index, 0, body_size);

    for(i = body_size-1; i >= index; i--)
    {
        ter = ter_group.members[| i];
        if(!is_undefined(ter) && instance_exists(ter))
        {
            ter.moving = false;
            if(ter.damage < ter.hp && self.alive)
            {
                ter.falling = true;
            }
        }
        ds_list_delete(ter_group.members, i);
    
        body_size = ds_list_size(ter_group.members);
    
        if(!is_undefined(ter) && instance_exists(ter) && body_size < head_size)
        {
            var la_player = ter.last_attacker_map[? "player"];
            var la_time = ter.last_attacker_map[? "step"];
            var what = ter.last_attacker_map[? "source"];
        
            var destroyed_by_guy = (what == guy_obj || what == emp_grenade_obj);
        
            if(!kill_awarded && ter.damage >= ter.hp && (singleton_obj.step_count - la_time) < ter.att_forget_delay
             && instance_exists(la_player))
            {
                var score_str = "";
                if(la_player != gamemode_obj.environment && destroyed_by_guy)
                {
                    var score_value = gamemode_obj.score_values[? "snake_killed"];
            
                    increase_stat(la_player, "score", score_value, false);
                    score_str = stat_label("score", score_value, "+");
                
                    kill_awarded = true;
                }
            
                battlefeed_post_destruction(id, ter.last_attacker_map, score_str);
            }
        
            if(living_head == noone && ter.damage < ter.hp && self.alive)
            {
                living_head = ter.id;
            }
        
            done_for = true;
        }
    }
        
    if(done_for && !kill_awarded && !trophy_created && living_head != noone)
    {
        trophy = instance_create(living_head.x, living_head.y, snake_trophy_obj);
        trophy.my_block = living_head.id;
        trophy.my_color = my_color;
        trophy_created = true;
    }
    
    return true;
}
