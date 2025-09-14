if(ready)
{
    /*
    draw_set_alpha(0.8);
    
    var filter = make_colour_rgb(sign(my_color & g_red)*255, sign(my_color & g_green)*255, sign(my_color & g_blue)*255);
    gpu_set_blendmode_ext(bm_dest_color, bm_src_alpha_sat);
    draw_roundrect_colour_ext(x1, y1, x2, y2,
                                corner_radius, corner_radius, filter, filter, false);
    */
    
    //gpu_set_blendmode(bm_normal);           
    
    draw_set_alpha(alpha/2);
    draw_roundrect_colour_ext(x1, y1, x2, y2,
                                corner_radius, corner_radius, tint, tint, false);
    draw_set_alpha(alpha/4);
    draw_roundrect_colour_ext(x1+border_size, y1+border_size, x2-border_size, y2-border_size,
                                corner_radius, corner_radius, tint, tint, true);
}

/*
draw_set_alpha(0.5);
draw_set_colour(c_aqua);
draw_rectangle(x-width/2, y-height/2, x+width/2, y+height/2,true);
*/
//draw_self();
/*
draw_set_colour(c_green);
draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, true);
*/

event_inherited();
