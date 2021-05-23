var help_guy;
sprite_index = one_way_down_spr;
if(inverted)
{
    sprite_index = one_way_up_spr;
}

if(my_guy == noone && my_player != gamemode_obj.environment)
{
    if(instance_exists(my_player) && instance_exists(my_player.my_guy))
    {
        my_guy = my_player.my_guy;
    }
}

my_color = g_white;
tint_updated = false;
var pass = id;

with(guy_obj)
{
    if(place_meeting(x,y, pass))
    {
        var help_guy = false;
        var throw_guy = false;
        var guy = id;
        
        with(pass)
        {
            if(my_guy == guy)
            {
                if(!inverted)
                {
                    if(guy.wanna_jump && !guy.looking_down)
                        help_guy = true;
                }
                else
                {
                    if(guy.wanna_jump && guy.looking_down)
                        throw_guy = true;
                    else
                        help_guy = true;
                }
            }
            else
            {
                if(!inverted)
                {
                    throw_guy = true;
                }
                else
                {
                    if(guy.bbox_bottom > bbox_top+1)
                    {
                        help_guy = true;
                    }
                }
            }
            
    
            if(throw_guy)
            {
                if(guy.vspeed < 0)
                    guy.vspeed = min(32, guy.vspeed/2);
                guy.vspeed += guy.gravity;
                if(inverted)
                {
                    sprite_index = one_way_down_spr;
                    my_color = g_dark;
                    tint_updated = false;
                }
            }
            
            if(help_guy)
            {
                if(!inverted)
                {
                    sprite_index = one_way_up_spr;
                    my_color = g_dark;
                    tint_updated = false;
                }
                
                if(guy.vspeed > 0)
                    guy.vspeed = min(32, guy.vspeed/2);
                guy.vspeed -= 1.3*guy.gravity;
                
            }
        }
    }
}
