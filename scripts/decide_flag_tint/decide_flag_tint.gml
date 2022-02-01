function decide_flag_tint(owner, view_player) {
    var flag_tint = c_white;
    var allied_flag_tint = make_color_rgb(0, 128, 255);
    var enemy_flag_tint = c_orange;
    
    if (view_player != noone) {
        if(iff_check("allied", view_player, owner))
        {
            flag_tint = allied_flag_tint;
        }
        if(iff_check("enemy", view_player, owner))
        {
            flag_tint = enemy_flag_tint;
        }
    }
    
    return flag_tint;
}