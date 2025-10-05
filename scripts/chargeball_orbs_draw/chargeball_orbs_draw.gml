/// @param {Id.Instance} ball charge_ball_obj
function chargeball_orbs_draw(ball) {
    if (!instance_exists(ball) || !instance_exists(ball.my_guy)) {
        return;
    }

    var debug = false;

    with (ball) {
        self.comp = color_to_components(self.my_guy.my_color);

        var cols_left = self.num_colors_used;
        var orbs_to_draw = self.my_guy.slots_absorbed - self.orb_count;

        if (debug) {
            show_debug_message("draw orbs start: " + string(orbs_to_draw));
            show_debug_message("num_colors_used: " + string(self.num_colors_used));
        }

        for (var ii = 0; ii < self.orb_count; ii++) {
            var orb = self.orbs[| ii];
            var col = orb.my_color;

            if (self.comp[col]) {
                self.comp[col] = 0;
                cols_left--;
            }
        }

        if (debug) {
            show_debug_message("cols_left: " + string(cols_left));
        }

        if (cols_left > orbs_to_draw) {
            chargeball_orbs_return(self.id);
            orbs_to_draw = self.my_guy.slots_absorbed;
            self.comp = color_to_components(self.my_guy.my_color);
            cols_left = self.num_colors_used;
            orbs_to_draw = max(orbs_to_draw, self.num_colors_used);
        }

        if (debug) {
            show_debug_message("draw orbs final: " + string(orbs_to_draw));
        }


        for (var col = g_dark; col <= g_blue; col++) {
            if (col == g_yellow)
                continue;

            if (self.comp[col]) {
                cols_left--;

                var belt = self.my_guy.orb_belts[? col];

                var tries = self.max_orbs;
                while (orbs_to_draw > cols_left && tries > 0) {
                    var orb = belt[| 0];

                    if (!is_undefined(orb) && instance_exists(orb)) {
                        orb_transfer(orb, self.my_guy, "belt", self.id, "orbit");
                        orbs_to_draw--;

                        if (debug) {
                            show_debug_message("orbs left: " + string(orbs_to_draw));
                        }
                    }

                    tries--;
                }
            }
        }
    }
}
