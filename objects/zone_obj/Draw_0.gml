draw_set_color(self.zone_debug_tint);

draw_set_alpha(0.2);
draw_rectangle(self.bbox_left, self.bbox_top, self.bbox_right, self.bbox_bottom, false);

draw_set_alpha(0.4);
draw_rectangle(self.bbox_left, self.bbox_top, self.bbox_right, self.bbox_bottom, true);

draw_set_alpha(1);
draw_set_color(c_white);
my_draw_set_font(label_font);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

var display_id = "";

if (self.zone_id != "") {
    display_id = self.zone_id;
}

if (display_id == "") {
    var group = self.my_groups[| 0];

    if (!is_undefined(group)) {
        display_id = self.my_keys[? group];
    }
}

if (display_id == "") {
    var triggerable = self.trigger_targets[| 0];

    if (!is_undefined(triggerable) && instance_exists(triggerable)) {
        display_id = object_get_name(triggerable.object_index);
    }
}

draw_text(self.bbox_left + 10, self.bbox_top + 10, display_id);
draw_text(self.bbox_left + 10, self.bbox_top + 42, string(ds_list_size(self.inside_list)));
