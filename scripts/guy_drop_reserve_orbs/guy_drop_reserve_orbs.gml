function guy_drop_reserve_orbs() {
    var ammo_drop_count = orb_reserve[? g_red] + orb_reserve[? g_green] + orb_reserve[? g_blue];
    var dir = 90, i;
    repeat(ammo_drop_count)
    {
        var xx = lengthdir_x(radius+32, dir);
        var yy = lengthdir_y(radius+32, dir);
            
        var orb_color = g_dark;
        while(orb_color == g_dark)
        {
            orb_color = irandom_range(g_red, g_blue);
            if(orb_color == g_yellow)
                orb_color = g_blue;
                    
            if(orb_reserve[? orb_color] >= 1)
                orb_reserve[? orb_color]--;
            else
                orb_color = g_dark;
        }
        i = instance_create(x+xx, y+yy, color_orb_obj);
        i.direction = dir;
        i.speed = 2;
        i.my_color = orb_color;
        i.my_guy = i.id;
        i.airborne = true;
        i.color_added = true;
        i.draw_label = false;
        i.holographic = holographic;
            
        dir += 360/ammo_drop_count;
    }
}