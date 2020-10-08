///@description ROTATION AND DEATH

image_angle += rotation_speed;
image_angle = image_angle mod 360;

if(done_for)
{
    var la_player = last_attacker_map[? "player"];
    var la_time = last_attacker_map[? "step"];
    var what = last_attacker_map[? "source"];
    
    var xx, yy, i, dir;
    
    if(instance_exists(la_player))
    {
        //if(la_player.object_index == player_obj)
        //{
            var full_score = false;
            var score_value = my_score_value;
            var score_str = "";

            if(what == guy_obj) 
            {   
                full_score = true;
                increase_stat(la_player,"mobs_killed_by_guy", 1, false);
                if(object_index == sprinkler_body_obj)
                {
                    increase_stat(la_player,"sprinklers_killed_by_guy", 1, false);
                }
                else if(object_index == slime_mob_obj)
                {
                    increase_stat(la_player,"slimes_killed_by_guy", 1, false);
                }
            }
   
            if(!full_score)
            {
                score_value = floor(score_value * 0.5);
            }
            
            if(la_player != my_player)
            {    
                score_str = stat_label("score", score_value, "+");
                
                increase_stat(la_player, "score", score_value, false);
            }

            battlefeed_post_destruction(id, id.last_attacker_map, score_str);
            
            increase_stat(la_player,"mobs_killed_total", 1, false);
            if(object_index == sprinkler_body_obj)
            {
                increase_stat(la_player,"sprinklers_killed_total", 1, false);
            }
            else if(object_index == slime_mob_obj)
            {
                increase_stat(la_player,"slimes_killed_total", 1, false);
            }
            
            var params = create_params_map();
            params[? "who"] = last_attacker_map[? "source_id"];
            params[? "who_player"] = la_player;
            
            broadcast_event("object_destroy", id, params);
        //}
    }
    
    dir = 90;
    repeat(ammo_drop_count)
    {
        xx = lengthdir_x(radius+32, dir);
        yy = lengthdir_y(radius+32, dir);
        i = instance_create(x+xx, y+yy, color_orb_obj);
        i.direction = dir;
        i.speed = 2;
        i.my_color = choose(g_red, g_green, g_blue);
        i.my_guy = i.id;
        i.airborne = true;
        i.color_added = true;
        
        dir += 360/ammo_drop_count;
    }
    
    repeat(crystal_drop_count)
    {
        xx = lengthdir_x(radius+32, dir);
        yy = lengthdir_y(radius+32, dir);
        i = instance_create(x+xx, y+yy, crystal_obj);
        i.direction = dir;
        i.speed = 2;
        i.my_color = choose(g_red, g_green, g_blue);
        i.my_guy = i.id;
        
        dir += 360/crystal_drop_count;
    }
    
    if(instance_exists(drop_item))
    {
        var item = drop_item;
        
        item.collected = false;
        item.my_guy = item.id;
        item.airborne = true;
        item.invisible = false;
            
        // A BIT OF MOVEMENT
        var xx = random(6)-3;
        var yy = random(6)-3;
            
        if(abs(xx) < 1)
            xx = sign(xx);
        if(abs(yy) < 1)
            yy = sign(yy);
                
        item.xprevious = x;
        item.yprevious = y;
        item.x = x + xx*5;
        item.y = y + yy*5;
        item.hspeed = xx/2;
        item.vspeed = yy/2;
    }
    
    instance_destroy();
    exit;
}

event_inherited();