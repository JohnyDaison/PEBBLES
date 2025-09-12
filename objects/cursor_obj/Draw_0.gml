var xx, yy;

if (keyboard_check(vk_alt) && false) {
    var left_end = -0.5, right_end = 1.5;
    
    xx = x + __view_get( e__VW.XView, view_current ) - view_get_xport( view_current );
    
    yy = y + __view_get( e__VW.YView, view_current ) - view_get_yport( view_current );
    
    draw_set_color(c_white);
    draw_set_alpha(1);
    draw_set_blend_mode_ext(bm_inv_dest_color,bm_src_alpha_sat);
    draw_rectangle(xx+left_end*square_side,yy-square_side/2,xx+right_end*square_side,yy+square_side/2,false);
    draw_set_blend_mode(bm_normal);
}


if (keyboard_check(vk_alt)) {
    var left_end = -1.5, right_end = 0.5; 
    
    xx = x + __view_get( e__VW.XView, view_current ) - view_get_xport( view_current );
    
    yy = y + __view_get( e__VW.YView, view_current ) - view_get_yport( view_current );
    
    /*
    draw_set_color(c_white);
    draw_set_alpha(0.5);
    draw_set_blend_mode_ext(bm_src_alpha,bm_src_alpha);
    draw_rectangle(xx+left_end*square_side,yy-square_side/2,xx+right_end*square_side,yy+square_side/2,false);
    draw_set_blend_mode(bm_normal);
    draw_set_alpha(1);
    */
    draw_set_alpha(1);
    draw_set_blend_mode_ext(bm_dest_color, bm_one);
    draw_circle_color(xx-square_side, yy-square_side, 240, make_color_rgb(255,0,0), c_black, 0);
    draw_circle_color(xx+square_side, yy-square_side, 240, make_color_rgb(0,255,0), c_black, 0);
    draw_circle_color(xx-square_side, yy+square_side, 240, make_color_rgb(0,0,255), c_black, 0);
    
    xx += 3*square_side;
    
    draw_set_alpha(0.5);
    draw_set_blend_mode_ext(bm_src_alpha, bm_one);
    draw_circle_colour(xx-square_side, yy-square_side, 60, make_color_rgb(255,0,0), c_black, 0);
    draw_circle_color(xx+square_side, yy-square_side, 60, make_color_rgb(0,255,0), c_black, 0);
    draw_circle_color(xx-square_side, yy+square_side, 60, make_color_rgb(0,0,255), c_black, 0);
    
    xx -= 3*square_side;
    yy += 3*square_side;
    /*
    draw_set_alpha(0.8);
    draw_set_blend_mode_ext(bm_inv_dest_color,bm_one);
    draw_circle_color(xx-square_side, yy-square_side, 160, make_color_rgb(255,0,0), c_black, 0);
    draw_circle_color(xx+square_side, yy-square_side, 160, make_color_rgb(0,255,0), c_black, 0);
    draw_circle_color(xx-square_side, yy+square_side, 160, make_color_rgb(0,0,255), c_black, 0);
    */
    draw_set_alpha(1);
    draw_set_blend_mode_ext(bm_dest_color,bm_src_alpha_sat);
    draw_circle_color(xx-square_side, yy-square_side, 40, make_color_rgb(255,0,0), make_color_rgb(255,0,0), 0);
    draw_circle_color(xx+square_side, yy-square_side, 40, make_color_rgb(0,255,0), make_color_rgb(0,255,0), 0);
    draw_circle_color(xx-square_side, yy+square_side, 40, make_color_rgb(0,0,255), make_color_rgb(0,0,255), 0);
    draw_set_blend_mode_ext(bm_inv_dest_color,bm_src_alpha_sat);
    draw_circle_color(xx+square_side, yy+square_side, 40, c_white, c_white, 0);
    draw_set_blend_mode(bm_normal); 
    draw_set_alpha(1);
}