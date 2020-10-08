with(guy_obj)
{
    if(my_player != gamemode_obj.environment)
    {
        if(my_color != my_player.number)
        {
            my_color = other.player_colors[? my_player.number];
            tint_updated = false;
        }
        if(!instance_exists(my_shield))
        {
            var inst = instance_create(x, y, shield_obj);
            inst.my_guy = id;
            inst.my_source = object_index;
            inst.my_player = self.my_player;
            //inst.max_charge = 1;
            inst.charge = inst.max_charge;
            inst.size_coef = 1.5;
            inst.field_ratio = 0.5;
            inst.field_power = 6;
            inst.my_color = place_controller_obj.current_color;
            inst.holographic = false;
            my_shield = inst.id;
        }
        else
        {
            my_shield.size_coef = 1.5 * (1 - 0.3 * clamp(my_player.ball_touches - place_controller_obj.allowed_touches, 0, 1));
        }
        
        damage = 0;
    }
}

if(!instance_exists(da_ball))
{
    da_ball = noone;
    
    with(player_obj)
    {   
        ball_touches = 0;
        touching_ball = false;
        was_touching_ball = false;
    }
    
    if(alarm[4] == -1 && !gamemode_obj.limit_reached && instance_exists(guy_obj))
    {
        alarm[4] = ball_respawn_wait;
    }
}
else
{
    var pl1 = gamemode_obj.players[? 1];
    var pl2 = gamemode_obj.players[? 2];
    var pl3 = gamemode_obj.players[? 3];
    var pl4 = gamemode_obj.players[? 4];

    if(pl1.touching_ball || (!is_undefined(pl3) && pl3.touching_ball))
    {
        pl2.ball_touches = 0;
        if(!is_undefined(pl4))
        {
            pl4.ball_touches = 0;
        }
    }
            
    if(pl2.touching_ball || (!is_undefined(pl4) && pl4.touching_ball))
    {
        pl1.ball_touches = 0;
        if(!is_undefined(pl3))
        {
            pl3.ball_touches = 0;
        }
    }
    
    with(player_obj)
    {
        if(id != gamemode_obj.environment)
        {
            if(was_touching_ball && !touching_ball)
            {
                ball_touches++;
                
                var teammate = noone; 
                with(player_obj)
                {
                    if(id != other.id && team_number == other.team_number)   
                    {
                        teammate = id;   
                    }
                }
                
                if(teammate != noone)
                {
                    teammate.ball_touches++;
                }
                
                /*
                if(ball_touches >= place_controller_obj.max_touches)
                {
                    place_controller_obj.da_ball.vspeed = 0;
                }
                */
                
                var new_color;
                
                do
                {
                    new_color = irandom_range(g_red, g_white);   
                }
                until(place_controller_obj.current_color != new_color)
                
                place_controller_obj.current_color = new_color;
                
                with(game_obj)
                {
                    if(!object_is_child(id, guy_obj))
                    {
                        if(my_color != g_black)
                        {
                            if(object_is_child(id, wall_obj))
                            {
                                my_next_color = place_controller_obj.current_color;
                            }
                            
                            my_color = place_controller_obj.current_color;
                            tint_updated = false;
                        }
                    }
                }
            }
            was_touching_ball = touching_ball;
            touching_ball = false;
            
            /*
            if(number == 1 && place_controller_obj.da_ball.x > room_width/2 + 32)
            {
                ball_touches = 0;
            }
            
            if(number == 2 && place_controller_obj.da_ball.x < room_width/2 - 32)
            {
                ball_touches = 0;
            }
            */
        }
    }
}

with(wall_obj)
{
    if(mod_get_state("indestr_terrain"))
    {
        color_locked = true;   
    }
    if(cover != cover_indestr)
    {
        if(energy > 0)
        {
            energy = max(0, energy - 0.01);
            if(energy == 0)
            {
                my_next_color = g_black;   
            }
        }
    }
}