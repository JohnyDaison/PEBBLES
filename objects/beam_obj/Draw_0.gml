// Note: "self.node_x" is "x" of "beam_head_node"
if (self.endpoint_reached && !self.invalid) {
    var last_node = ds_list_size(self.beam_nodes) - 1;

    self.updateFacing();

    // BEAM GOES OUTSIDE ROOM
    if (!self.collided) {
        var node = self.beam_nodes[| 0];
        draw_sprite_ext(beam_start, self.image_index, node.x, self.y, self.facing, 1, 0, self.tint, self.image_alpha);

        if (self.beam_head_fired && !self.beam_head_landed) {
            draw_sprite_ext(beam_head, self.image_index, self.node_x + self.beam_head_dist, self.y, self.head_facing, 1, 0, self.tint, self.image_alpha);
        }

        var phase_str = "";

        for (var ii = node.x; sign((1 + 1.1 * self.facing) * room_width / 2 - ii) == self.facing; ii += self.beam_speed * self.facing) {
            var next_ii = ii + self.beam_speed * self.facing;

            // DETECT PHASE CHANGE
            if (self.beam_head_fired) {
                if (self.beam_draw_phase != 0 && sign(self.node_x + self.beam_head_dist - ii) == self.facing) {
                    self.beam_draw_phase = 0;
                    self.radii_updated = false;
                }

                if (self.beam_draw_phase != 2 && sign(ii - (self.node_x + self.beam_head_dist)) == self.facing) {
                    self.beam_draw_phase = 2;
                    self.radii_updated = false;
                }

                if (self.beam_draw_phase != 1 && sign((self.node_x + self.beam_head_dist) - ii) == self.facing && sign(next_ii - (self.node_x + self.beam_head_dist)) == self.facing) {
                    self.beam_draw_phase = 1;
                    self.radii_updated = false;
                }
            }

            if (self.beam_draw_phase != 2 && !self.beam_head_fired) {
                self.beam_draw_phase = 2;
                self.radii_updated = false;
            }

            // UPDATE RADII WHEN PHASE CHANGES
            if (!self.radii_updated) {
                self.updateRadii();

                self.radii_updated = true;
            }

            // SETUP BEAM PART DRAWING
            var highlight = false;

            repeat(2) {
                if (highlight) {
                    draw_set_color(c_white);
                    draw_set_alpha(self.beam_alpha * self.beam_highlight_ratio);
                    draw_primitive_begin_texture(pr_trianglelist, self.beam_high_tex);

                    highlight = false;
                }
                else {
                    draw_set_color(self.tint);
                    draw_set_alpha(self.beam_alpha);
                    draw_primitive_begin_texture(pr_trianglelist, self.beam_tex);

                    highlight = true;
                }

                var flip = 1;

                // DRAW CORE TRIANGLES

                repeat(2) {
                    draw_vertex_texture(ii, self.y - self.core_radius * flip, 0, self.beam_tex_glow_end);

                    repeat(2) {
                        draw_vertex_texture(ii, self.y, 0, 1);
                        draw_vertex_texture(next_ii, self.y - self.next_core_radius * flip, 1, self.beam_tex_glow_end);
                    }

                    draw_vertex_texture(next_ii, self.y, 1, 1);

                    flip *= -1;
                }

                // DRAW GLOW TRIANGLES

                repeat(2) {
                    draw_vertex_texture(ii, self.y - self.beam_radius * flip, 0, self.beam_tex_glow_start);

                    repeat(2) {
                        draw_vertex_texture(ii, self.y - self.core_radius * flip, 0, self.beam_tex_glow_end);
                        draw_vertex_texture(next_ii, self.y - self.next_beam_radius * flip, 1, self.beam_tex_glow_start);
                    }

                    draw_vertex_texture(next_ii, self.y - self.next_core_radius * flip, 1, self.beam_tex_glow_end);

                    flip *= -1;
                }

                draw_primitive_end();
            }
        }

        draw_sprite_ext(beam_start_highlight, self.image_index, node.x, self.y, self.facing, 1, 0, c_white, self.image_alpha * self.beam_highlight_ratio);

        if (self.beam_head_fired && !self.beam_head_landed) {
            draw_sprite_ext(beam_head_highlight, self.image_index, self.node_x + self.beam_head_dist, self.y, self.head_facing, 1, 0, c_white, self.image_alpha * self.beam_highlight_ratio);
        }
        //show_debug_message("phases: "+phase_str);
    }

    //BEAM HITS SOMETHING
    else {
        var node_fix = 0;
        var next_node_fix = 0;

        for (var i = 0; i <= last_node; i += 1) {
            var node = self.beam_nodes[| i];

            if (i != 0) {
                node_fix = next_node_fix;
            }

            if (i <= last_node - 1) {
                var next_node = self.beam_nodes[| i + 1];

                if (!(instance_exists(node) && instance_exists(next_node))) {
                    break;
                }

                if (object_is_ancestor(next_node.object_index, terrain_obj)) {
                    next_node_fix = 16 - self.facing * 16;
                }

                if (next_node.object_index == shield_obj) {
                    next_node_fix = -self.facing * 20;
                }

                // DRAW START SPRITE
                if (i == 0) {
                    draw_sprite_ext(beam_start, self.image_index, node.x, self.y, self.facing, 1, 0, self.tint, self.image_alpha);
                }

                // DRAW END SPRITE
                if (i == last_node - 1) {
                    draw_sprite_ext(beam_end_sprite, self.image_index, next_node.x + next_node_fix, self.y, self.facing, 1, 0, self.tint, self.image_alpha);
                }

                // DRAW HEAD SPRITE
                if (self.beam_head_fired && !self.beam_head_landed) {
                    draw_sprite_ext(beam_head, self.image_index, self.node_x + beam_head_dist, self.y, self.head_facing, 1, 0, self.tint, self.image_alpha);
                }

                var phase_str = "";

                for (var ii = node.x + node_fix; sign((next_node.x + next_node_fix) - ii) == self.facing; ii += self.beam_speed * self.facing) {
                    var next_ii = ii + self.beam_speed * self.facing;

                    if (abs(ii - (next_node.x + next_node_fix)) <= self.beam_speed) {
                        next_ii = next_node.x + next_node_fix;
                    }

                    // DETECT PHASE CHANGE
                    if (self.beam_head_fired) {
                        if (self.beam_draw_phase != 0 && (i < self.beam_head_node || (i == self.beam_head_node && sign(self.node_x + self.beam_head_dist - (ii - node_fix)) == self.facing))) {
                            self.beam_draw_phase = 0;
                            self.radii_updated = false;
                        }

                        if (self.beam_draw_phase != 2 && (i > self.beam_head_node || (i == self.beam_head_node && sign((ii - node_fix) - (self.node_x + self.beam_head_dist)) == self.facing))) {
                            self.beam_draw_phase = 2;
                            self.radii_updated = false;
                        }

                        if (beam_draw_phase != 1 && i == beam_head_node && sign((self.node_x + beam_head_dist) - (ii - node_fix)) == facing && sign((next_ii - node_fix) - (self.node_x + beam_head_dist)) == facing) {
                            self.beam_draw_phase = 1;
                            self.radii_updated = false;
                        }
                    }

                    if (self.beam_draw_phase != 2 && !self.beam_head_fired) {
                        self.beam_draw_phase = 2;
                        self.radii_updated = false;
                    }

                    if (self.beam_draw_phase != 0 && self.beam_head_landed) {
                        self.beam_draw_phase = 0;
                        self.radii_updated = false;
                    }

                    // UPDATE RADII WHEN PHASE CHANGES
                    if (!self.radii_updated) {
                        self.updateRadii();

                        self.radii_updated = true;
                    }

                    // SETUP BEAM PART DRAWING
                    var highlight = false;

                    repeat(2) {
                        if (!highlight) {
                            draw_set_color(self.tint);
                            draw_set_alpha(self.beam_alpha);
                            draw_primitive_begin_texture(pr_trianglelist, self.beam_tex);

                            highlight = true;
                        }
                        else {
                            draw_set_color(c_white);
                            draw_set_alpha(self.beam_alpha * self.beam_highlight_ratio);
                            draw_primitive_begin_texture(pr_trianglelist, self.beam_high_tex);

                            highlight = false;
                        }

                        var flip = 1;

                        // DRAW CORE TRIANGLES

                        repeat(2) {
                            draw_vertex_texture(ii, self.y - self.core_radius * flip, 0, self.beam_tex_glow_end);

                            repeat(2) {
                                draw_vertex_texture(ii, self.y, 0, 1);
                                draw_vertex_texture(next_ii, self.y - self.next_core_radius * flip, 1, self.beam_tex_glow_end);
                            }

                            draw_vertex_texture(next_ii, self.y, 1, 1);

                            flip *= -1;
                        }

                        flip = 1;

                        // DRAW GLOW TRIANGLES

                        repeat(2) {
                            draw_vertex_texture(ii, self.y - self.beam_radius * flip, 0, self.beam_tex_glow_start);

                            repeat(2) {
                                draw_vertex_texture(ii, self.y - self.core_radius * flip, 0, self.beam_tex_glow_end);
                                draw_vertex_texture(next_ii, self.y - self.next_beam_radius * flip, 1, self.beam_tex_glow_start);
                            }

                            draw_vertex_texture(next_ii, self.y - self.next_core_radius * flip, 1, self.beam_tex_glow_end);

                            flip *= -1;
                        }

                        draw_primitive_end();
                    }
                }

                //show_debug_message("phases: "+phase_str);

                // HIGHLIGHTS

                // DRAW START SPRITE
                if (i == 0) {
                    draw_sprite_ext(beam_start_highlight, self.image_index, node.x, self.y, self.facing, 1, 0, c_white, self.image_alpha * self.beam_highlight_ratio);
                }

                // DRAW END SPRITE
                if (i == last_node - 1) {
                    draw_sprite_ext(beam_end_highlight, self.image_index, next_node.x + next_node_fix, self.y, self.facing, 1, 0, c_white, self.image_alpha * self.beam_highlight_ratio);
                }

                // DRAW HEAD SPRITE
                if (self.beam_head_fired && !self.beam_head_landed) {
                    draw_sprite_ext(beam_head_highlight, self.image_index, self.node_x + self.beam_head_dist, self.y, self.head_facing, 1, 0, c_white, self.image_alpha * self.beam_highlight_ratio);
                }
            }

            self.facing *= -1;
        }
    }
    draw_set_alpha(1);
}

event_inherited();
