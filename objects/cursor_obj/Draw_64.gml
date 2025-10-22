/// @description  CURSOR, TOOLTIP
if (self.sprite_index != no_sprite) {
    draw_sprite_ext(self.sprite_index, 0, self.x, self.y, 1, 1, 0, c_white, 1);
    draw_sprite_ext(self.sprite_index, 1, self.x, self.y, 1, 1, 0, self.tint, self.glow_ratio);
    draw_sprite_ext(self.sprite_index, 0, self.x, self.y, 1, 1, 0, c_white, 0.2);
}

if (self.active_tool != noone) {
    draw_sprite_ext(target_cross2, 0, self.x, self.y, 1, 1, 0, c_white, 1);
}

if (self.tooltip != "") {
    my_draw_set_font(label_font);
    draw_set_color(self.tint);
    draw_set_alpha(1);
    draw_set_halign(fa_left);
    draw_set_valign(fa_bottom);
    
    var text = self.tooltip;
    var tip_x = self.x + 8;
    var tip_y = self.y - 8;
    
    draw_set_color(self.tooltip_bg_color);
    var width = string_width(text);
    draw_roundrect(tip_x - 4, tip_y - 26, tip_x + width, tip_y + 2, false);
    
    // TODO: rewrite this line
    draw_set_color(c_gray - self.tooltip_color);
    var i = -1;
    
    repeat(2) {
        my_draw_text(tip_x + i, tip_y + i, text);
        i = 1;
    }
    
    draw_set_color(self.tooltip_color);
    my_draw_text(tip_x, tip_y, text);
}

var showInverseFilterForGUI = false;

/// DISABLED
if (showInverseFilterForGUI && keyboard_check(vk_alt)) {
    draw_set_color(c_white);
    draw_set_alpha(1);
    gpu_set_blendmode_ext(bm_inv_dest_color, bm_src_alpha_sat);
    draw_rectangle(self.x - 33, self.y - 100, self.x + 100, self.y + 100, false);
    gpu_set_blendmode(bm_normal);
}
