event_inherited();

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
my_draw_set_font(self.msg_font);
draw_set_alpha(self.fade_ratio);
var yy = self.y + self.content_spacing;

for (var i = 0; i < self.msg_count; i += 1) {
    var feed_str = self.msg_list[| i];
    var feed_item = feed_str;
    //yy = y + content_spacing + 0.5*msg_height + i*(msg_height + content_spacing);

    if (is_string(feed_str)) {
        yy += 16 + self.padding_size;

        draw_set_color(c_black);
        my_draw_text(self.x + self.width / 2, yy + 1, feed_str);
        draw_set_color(c_orange);
        my_draw_text(self.x + self.width / 2, yy, feed_str);

        yy += 16 + self.padding_size + self.content_spacing;
    }
    else if (instance_exists(feed_item)) {
        var xx = self.x + floor(self.width / 2 - feed_item.width / 2);
        yy += (feed_item.height / 2 + self.padding_size);

        var blinkend_ratio = max(0, feed_item.init_fade_ratio - feed_item.blinkin_duration);
        var bg_color = merge_colour(c_black, DB.colormap[? "bf_orange"], max(0, (feed_item.fade_ratio - blinkend_ratio)) / feed_item.blinkin_duration);
        var max_content_height = 0;

        for (var ii = 0; ii < feed_item.content_length; ii++) {
            var content_type = feed_item.type[? ii];
            var content = feed_item.content[? ii];
            var content_color = feed_item.tint[? ii];
            var content_facing = feed_item.facing[? ii];
            var content_width = 0;
            var content_height = 0;

            if (!is_undefined(content_type) && content_type != "blank") {
                if (content_type == "text") {
                    content_width = string_width(content);
                    content_height = string_height(content);

                    draw_set_alpha(min(1, feed_item.fade_ratio) * self.item_bg_alpha);
                    draw_set_color(bg_color);
                    draw_roundrect_ext(xx - self.padding_size,
                                       yy - ceil(content_height / 2) - self.padding_size,
                                       xx + content_width + self.padding_size,
                                       yy + floor(content_height / 2) + self.padding_size,
                                       self.corner_radius, self.corner_radius, false);

                    xx += floor(content_width / 2) + 1;


                    draw_set_alpha(feed_item.fade_ratio);
                    draw_set_color(c_black);
                    my_draw_text(xx, yy + 1, content, false);
                    draw_set_color(content_color);
                    my_draw_text(xx, yy, content, false);

                    xx += floor(content_width / 2);
                }
                else if (content_type == "icon") {
                    content_width = sprite_get_width(content);
                    content_height = sprite_get_height(content);

                    draw_set_alpha(min(1, feed_item.fade_ratio) * self.item_bg_alpha);
                    draw_set_color(bg_color);
                    draw_roundrect_ext(xx - self.padding_size,
                                       yy - ceil(content_height / 2) - self.padding_size,
                                       xx + content_width + self.padding_size,
                                       yy + floor(content_height / 2) + self.padding_size,
                                       self.corner_radius, self.corner_radius, false);

                    xx += floor(content_width / 2) + 1;

                    draw_sprite_ext(content, 0, xx, yy, content_facing, 1, 0, content_color, feed_item.fade_ratio);

                    xx += floor(content_width / 2);
                }

                xx += self.content_spacing;

                if (feed_item.height == 0 && max_content_height < content_height) {
                    max_content_height = content_height;
                }
            }
        }

        if (feed_item.height == 0) {
            feed_item.height = max_content_height;
        }

        yy += (feed_item.height / 2 + self.padding_size + self.content_spacing);
    }
}

self.height = yy - self.y;
