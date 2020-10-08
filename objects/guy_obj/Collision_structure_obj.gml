var guy = id;

if(other.object_index == cannon_base_obj)
{
    var cannon = other;
    var cannon_operational = !cannon.destroyed && cannon.immovable;
    
    if(cannon_operational)
    {
        var guy_wants_to_exit = guy.looking_down || (guy.hor_dir_held && guy.wanna_abi);
        var guy_can_enter = !guy.lost_control && cannon.my_player == guy.my_player
        
        if(!guy_wants_to_exit && guy_can_enter)
        {
            var guy_seat_y = cannon.y + cannon.guy_y_offset;
            
            if(y >= guy_seat_y)
            {
                y -= 1;        
                y = max(y, guy_seat_y);
                
                var x_diff = cannon.x - x;
                
                if(abs(x_diff) > 1)
                {
                    x += sign(x_diff);
                }
                else
                {
                    x = cannon.x;
                }
                
                guy.seated = true;
            }   
        }
    }
}
else
{
    var structure = other;
    // move up if feet slightly below the walkable surface and not wanting to jump down
    if(!guy.holding_wall && structure.walkable
    && (!structure.holographic || guy.holographic)
    && !(guy.jumping_down && guy.last_jumped_down == structure.id)
    && (structure.my_player == gamemode_obj.environment || structure.my_player == guy.my_player)
    && guy.vspeed >= 0
    && ((guy.bbox_bottom-1) <= structure.bbox_bottom && guy.y <= structure.y && (guy.bbox_bottom-1) <= structure.bbox_top + 15)
    && !place_meeting(x, y-2, terrain_obj)) // && !place_meeting(x,y+1,terrain_obj)
    {
        y -= 1;
    }
}

