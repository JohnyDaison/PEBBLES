draw_set_color(c_white);
draw_sprite(jump_pad_base_spr, self.image_index, self.x + self.spr_xoffset, self.y + self.spr_yoffset);
draw_sprite_ext(jump_pad_top_spr, round(self.ready), self.x + self.spr_xoffset, self.y + self.spr_yoffset, 1, 1, 0, self.final_tint, self.image_alpha);

event_inherited();
