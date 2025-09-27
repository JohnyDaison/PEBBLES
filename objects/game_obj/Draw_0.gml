if (singleton_obj.draw_bboxes) {
    var merged_color = merge_color(self.tint, c_white, 0.5);
    draw_set_color(merged_color);
    draw_set_alpha(0.5);
    draw_rectangle(self.bbox_left, self.bbox_top, self.bbox_right, self.bbox_bottom, false);
    draw_set_alpha(1);
}

if (self.read_terrain && singleton_obj.draw_ter_lists) {
    draw_set_color(c_white);

    for (var ii = 0; ii < self.ter_list_length; ii += 1) {
        var ter_block = self.ter_list[| ii];

        if (instance_exists(ter_block)) {
            draw_sprite(ter_highlight_spr, 0, ter_block.x, ter_block.y);
        }
    }
}

if ((singleton_obj.draw_object_labels || self.draw_label) && !self.invisible && sprite_exists(self.sprite_index) && self.name != "") {
    my_draw_set_font(label_font);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    var label_height = self.label_scale * string_height(self.name) + 4;
    var label_width = self.label_scale * string_width(self.name) + 4;
    var halfHeight = floor(label_height / 2);
    var halfWidth = floor(label_width / 2);

    var xx = self.x;
    var yy = self.y - sprite_get_yoffset(self.sprite_index) - self.label_distance;

    draw_set_color(c_black);
    draw_set_alpha(0.5 * self.label_alpha);
    draw_rectangle(xx - halfWidth, yy - halfHeight, xx + halfWidth, yy + halfHeight, false);

    draw_set_color(c_white);
    draw_set_alpha(self.label_alpha);
    
    if (self.label_scale == 1) {
        my_draw_text(xx, yy, self.name);
    }
    else {
        my_draw_text_transformed(xx, yy, self.name, self.label_scale, self.label_scale, 0);
    }

    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}

if (singleton_obj.draw_depths) {
    my_draw_set_font(little_font);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    var depth_str = string(self.depth);
    var label_height = string_height(depth_str) + 4;
    var label_width = string_width(depth_str) + 4;
    var halfHeight = floor(label_height / 2);
    var halfWidth = floor(label_width / 2);

    draw_set_color(c_black);
    draw_set_alpha(1);
    draw_rectangle(self.x - halfWidth, self.y - halfHeight, self.x + halfWidth, self.y + halfHeight, false);

    draw_set_color(c_white);
    my_draw_text(self.x, self.y, depth_str);

    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}
