event_inherited();

var cur_y = y-step-hover_offset;
var view_player = gamemode_obj.find_player_by_view(view_current);
var flag_tint = decide_flag_tint(my_flag_spawner, view_player);

draw_sprite_ext(flag_icon, 0, x, cur_y, 0.5, 0.5, 0, flag_tint, flag_alpha);