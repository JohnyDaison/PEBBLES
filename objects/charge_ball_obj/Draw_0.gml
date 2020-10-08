draw_sprite_ext(charge_ball2_spr,image_index,x,y,image_xscale,image_yscale,image_angle,self.glow_tint,image_alpha*self.holo_alpha);
//draw_sprite_ext(charge_ball3_highlight,image_index,x,y,sprite_size,sprite_size,0,c_white,image_alpha*0.5);

if(instance_exists(my_guy) && (charging || firing))
{
    draw_set_color(glow_tint);
    draw_set_alpha(lightning_alpha);
    
    var start_x = my_guy.x + center_offset_x;
    var start_y = my_guy.y + center_offset_y;
    
    /*
    var x1 = start_x;
    var y1 = start_y;
    
    lgt_r1 = -(charge)*lightning_width; 
    lgt_r2 = (charge)*lightning_width;

    for(var i = 1; i<=lightning_steps; i++)
    {
        x2 = start_x + rel_x*(i/lightning_steps) + random_range(lgt_r1, lgt_r2); 
        y2 = start_y + rel_y*(i/lightning_steps) + random_range(lgt_r1, lgt_r2);
        if(i==lightning_steps)
        {
            x2 = x;
            y2 = y;
        }
        draw_line_width(x1,y1,x2,y2,lightning_thickness);
        x1 = x2;
        y1 = y2;
    }
    */
    
    draw_lightning_width(start_x, start_y, x,y, 2*lightning_width*charge, lightning_steps, lightning_thickness);
}

event_inherited();