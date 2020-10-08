if(active)
{
    draw_set_blend_mode_ext(bm_inv_dest_color,bm_src_alpha_sat);
    draw_set_colour(c_ltgray);
    draw_rectangle(field_left, field_top, field_right, field_bottom, false); 
    draw_set_blend_mode(bm_normal); 
}

action_inherited();
