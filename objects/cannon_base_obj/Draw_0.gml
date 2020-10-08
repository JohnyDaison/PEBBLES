draw_set_alpha(1);

if(instance_exists(charge_ball))
{
    var dir = point_direction(x,y,charge_ball.x,charge_ball.y);
    draw_sprite_ext(cannon_barrel2_spr, barrel_anim_index, 
        x + lengthdir_x(barrel_dist, dir),
        y + lengthdir_y(barrel_dist, dir),
        1,1, dir, charge_ball.tint, 0.9);
}

draw_set_colour(c_white);
draw_sprite(sprite_index, 0, x, y);
draw_sprite_ext(sprite_index, 1, x,y, 1,1,0, DB.colormap[? shot_color], 1);

draw_set_colour(c_white);
draw_sprite(platform_spr, 0, x, y+40);

// HP
if(damage < hp)
{
    //hp_str = string(ceil((hp-damage)*100));
    hp_ratio = (hp-damage)/hp;
    //draw_sprite(cannon_ammo_spr, 0, gui_x, gui_y+hp_y_offset);
    /*
    my_draw_set_font(hp_font);
    draw_set_color(c_black);
    my_draw_text(gui_x+2, gui_y+hp_y_offset+2, hp_str);
    draw_set_color(c_yellow);
    my_draw_text(gui_x, gui_y+hp_y_offset, hp_str);
    */
    
    hpbar_xx = hpbar_x1 + hp_ratio*hpbar_width;
    
    // BG
    draw_set_colour(c_dkgray);
    draw_rectangle(x + hpbar_x1, y + hpbar_y1, x + hpbar_x2, y + hpbar_y2, false);
    
    // BAR
    draw_set_colour(hpbar_tint);
    draw_rectangle(x + hpbar_x1, y + hpbar_y1, x + hpbar_xx, y + hpbar_y2, false);
       
    // COVER
    draw_sprite(cannon_hpbar_cover_spr, 0, x, y);
}   

event_inherited();
