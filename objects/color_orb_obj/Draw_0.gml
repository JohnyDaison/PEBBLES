if (instance_exists(self.my_guy)) {
    if (self.sprite_index != no_sprite) {
        draw_sprite_ext(self.sprite_index, self.image_index,
                        self.x, self.cur_y, self.size, self.size,
                        0, self.tint, self.fade_counter * image_alpha * 0.5 * self.holo_alpha);

        if (self.my_color > g_dark) {
            var core_tint = c_white;

            if (self.draw_lightning) {
                if (self.lightning_color > g_dark) {
                    core_tint = DB.colormap[? self.lightning_color];
                }

                var lightning_tint = core_tint;

                draw_sprite_ext(tiny_glowcore_spr, self.image_index,
                                self.x, self.cur_y, self.size, self.size,
                                0, core_tint, self.fade_counter * image_alpha * 0.5);

                draw_set_color(lightning_tint);
                draw_set_alpha(self.lightning_alpha * self.holo_alpha);

                draw_lightning_width(self.x, self.cur_y, self.lightning_x, self.lightning_y,
                                     self.lightning_width, self.lightning_steps, self.lightning_thickness);
            }

            if (instance_exists(self.drained_object)) {
                draw_set_color(self.tint);
                draw_set_alpha(self.lightning_alpha * self.holo_alpha);

                var x_center = self.drained_object.x;
                var y_center = self.drained_object.y;

                if (self.drained_object.object_index == wall_obj) {
                    x_center += 15;
                    y_center += 15;
                }

                draw_lightning_width(self.x, self.cur_y, x_center, y_center,
                                     self.lightning_width, self.lightning_steps, self.lightning_thickness);
            }
        }

        part_system_drawit(self.part_system);
    }
}
/*
my_draw_set_font(label_font);
my_draw_text(self.x + 16, self.y + 16, "[" + string(self.chunkgrid_x) + "," + string(self.chunkgrid_y) + "]");
*/

event_inherited();
