if(active)
{
    gpu_set_blendmode_ext(bm_inv_dest_color,bm_src_alpha_sat);
    draw_set_colour(c_ltgray);
    draw_rectangle(field_left, field_top, field_right, field_bottom, false); 
    gpu_set_blendmode(bm_normal); 
}

action_inherited();
