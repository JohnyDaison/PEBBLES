event_inherited();

var cur_y = self.y - self.step - self.hover_offset;
var view_player = gamemode_obj.find_player_by_view(view_current);
var flag_tint = decide_flag_tint(self.my_flag_spawner, view_player);

draw_sprite_ext(self.flag_icon, 0, self.x, cur_y, 0.5, 0.5, 0, flag_tint, self.flag_alpha);
