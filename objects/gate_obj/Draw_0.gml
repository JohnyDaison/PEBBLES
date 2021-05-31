draw_sprite_ext(gate_spr, 0, x,y, 1,1, 0, tint, 1);

for(var i=0; i<4; i++)
{
    if(enabled[? i])
    {
        var xx = 1, xcor = 0,
            yy = 1, ycor = 0,
            cur_tint, cover_tint;
            
        if(i==1)
            ycor = 1;
        if(i==2)
            xcor = 1;
        if(i>1)
            xx = -1;
            
        var sprite = gate_enabled_spr,
            cur_tint = DB.colormap[? g_dark];
            
        if(active[? i])
        {
            sprite = gate_active_spr;
            cur_tint = DB.colormap[? g_white];   
        }
        
        if(!tint_updated)
        {
            sprite = gate_changing_spr;
        }
        
        cover_tint = DB.colormap[? g_dark];
        if(instance_exists(my_block))
        {
            cover_tint = my_block.tint;
        }
        
        draw_sprite_ext(sprite, 0, x+xcor,y+ycor, xx,yy, i mod 2*90, cover_tint, 1);
        draw_sprite_ext(sprite, 1, x+xcor,y+ycor, xx,yy, i mod 2*90, cur_tint, 1);
    }
}

event_inherited();
