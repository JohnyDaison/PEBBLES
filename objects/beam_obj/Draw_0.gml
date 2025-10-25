// Note: "self.node_x" is "x" of "beam_head_node"
if (self.endpoint_reached && !self.invalid) {
    var last_node = ds_list_size(self.beam_nodes) - 1;
    var beamHeadX = self.node_x + self.beam_head_dist;

    self.updateFacing();

    // BEAM GOES OUTSIDE ROOM
    if (!self.collided) {
        var node = self.beam_nodes[| 0];
        self.drawBaseSprite(beam_start, node.x, self.facing);

        if (self.beam_head_fired && !self.beam_head_landed) {
            self.drawBaseSprite(beam_head, beamHeadX, self.head_facing);
        }

        var phase_str = "";

        for (var xx = node.x; sign((1 + 1.1 * self.facing) * room_width / 2 - xx) == self.facing; xx += self.beam_speed * self.facing) {
            var next_ii = xx + self.beam_speed * self.facing;

            // DETECT PHASE CHANGE
            if (self.beam_head_fired) {
                if (self.beam_draw_phase != 0 && sign(beamHeadX - xx) == self.facing) {
                    self.beam_draw_phase = 0;
                    self.radii_updated = false;
                }

                if (self.beam_draw_phase != 2 && sign(xx - beamHeadX) == self.facing) {
                    self.beam_draw_phase = 2;
                    self.radii_updated = false;
                }

                if (self.beam_draw_phase != 1 && sign(beamHeadX - xx) == self.facing && sign(next_ii - beamHeadX) == self.facing) {
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
                    draw_vertex_texture(xx, self.y - self.core_radius * flip, 0, self.beam_tex_glow_end);

                    repeat(2) {
                        draw_vertex_texture(xx, self.y, 0, 1);
                        draw_vertex_texture(next_ii, self.y - self.next_core_radius * flip, 1, self.beam_tex_glow_end);
                    }

                    draw_vertex_texture(next_ii, self.y, 1, 1);

                    flip *= -1;
                }

                // DRAW GLOW TRIANGLES

                repeat(2) {
                    draw_vertex_texture(xx, self.y - self.beam_radius * flip, 0, self.beam_tex_glow_start);

                    repeat(2) {
                        draw_vertex_texture(xx, self.y - self.core_radius * flip, 0, self.beam_tex_glow_end);
                        draw_vertex_texture(next_ii, self.y - self.next_beam_radius * flip, 1, self.beam_tex_glow_start);
                    }

                    draw_vertex_texture(next_ii, self.y - self.next_core_radius * flip, 1, self.beam_tex_glow_end);

                    flip *= -1;
                }

                draw_primitive_end();
            }
        }

        self.drawHighlightSprite(beam_start_highlight, node.x, self.facing);

        if (self.beam_head_fired && !self.beam_head_landed) {
            self.drawHighlightSprite(beam_head_highlight, beamHeadX, self.head_facing);
        }
    }

    //BEAM HITS SOMETHING
    else {
        var node_fix = 0;
        var next_node_fix = 0;

        for (var nodeIndex = 0; nodeIndex <= last_node; nodeIndex += 1) {
            var node = self.beam_nodes[| nodeIndex];

            if (nodeIndex != 0) {
                node_fix = next_node_fix;
            }

            if (nodeIndex <= last_node - 1) {
                var next_node = self.beam_nodes[| nodeIndex + 1];

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
                if (nodeIndex == 0) {
                    self.drawBaseSprite(beam_start, node.x, self.facing);
                }

                // DRAW END SPRITE
                if (nodeIndex == last_node - 1) {
                    self.drawBaseSprite(beam_end_sprite, next_node.x + next_node_fix, self.facing);
                }

                // DRAW HEAD SPRITE
                if (self.beam_head_fired && !self.beam_head_landed) {
                    self.drawBaseSprite(beam_head, beamHeadX, self.head_facing);
                }

                var phase_str = "";

                for (var xx = node.x + node_fix; sign((next_node.x + next_node_fix) - xx) == self.facing; xx += self.beam_speed * self.facing) {
                    var next_ii = xx + self.beam_speed * self.facing;

                    if (abs(xx - (next_node.x + next_node_fix)) <= self.beam_speed) {
                        next_ii = next_node.x + next_node_fix;
                    }

                    // DETECT PHASE CHANGE
                    if (self.beam_head_fired) {
                        if (self.beam_draw_phase != 0 && (nodeIndex < self.beam_head_node || (nodeIndex == self.beam_head_node && sign(beamHeadX - (xx - node_fix)) == self.facing))) {
                            self.beam_draw_phase = 0;
                            self.radii_updated = false;
                        }

                        if (self.beam_draw_phase != 2 && (nodeIndex > self.beam_head_node || (nodeIndex == self.beam_head_node && sign((xx - node_fix) - beamHeadX) == self.facing))) {
                            self.beam_draw_phase = 2;
                            self.radii_updated = false;
                        }

                        if (self.beam_draw_phase != 1 && nodeIndex == self.beam_head_node && sign(beamHeadX - (xx - node_fix)) == self.facing && sign((next_ii - node_fix) - beamHeadX) == self.facing) {
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
                            draw_vertex_texture(xx, self.y - self.core_radius * flip, 0, self.beam_tex_glow_end);

                            repeat(2) {
                                draw_vertex_texture(xx, self.y, 0, 1);
                                draw_vertex_texture(next_ii, self.y - self.next_core_radius * flip, 1, self.beam_tex_glow_end);
                            }

                            draw_vertex_texture(next_ii, self.y, 1, 1);

                            flip *= -1;
                        }

                        flip = 1;

                        // DRAW GLOW TRIANGLES

                        repeat(2) {
                            draw_vertex_texture(xx, self.y - self.beam_radius * flip, 0, self.beam_tex_glow_start);

                            repeat(2) {
                                draw_vertex_texture(xx, self.y - self.core_radius * flip, 0, self.beam_tex_glow_end);
                                draw_vertex_texture(next_ii, self.y - self.next_beam_radius * flip, 1, self.beam_tex_glow_start);
                            }

                            draw_vertex_texture(next_ii, self.y - self.next_core_radius * flip, 1, self.beam_tex_glow_end);

                            flip *= -1;
                        }

                        draw_primitive_end();
                    }
                }

                // HIGHLIGHTS

                // DRAW START SPRITE
                if (nodeIndex == 0) {
                    self.drawHighlightSprite(beam_start_highlight, node.x, self.facing);
                }

                // DRAW END SPRITE
                if (nodeIndex == last_node - 1) {
                    self.drawHighlightSprite(beam_end_highlight, next_node.x + next_node_fix, self.facing);
                }

                // DRAW HEAD SPRITE
                if (self.beam_head_fired && !self.beam_head_landed) {
                    self.drawHighlightSprite(beam_head_highlight, beamHeadX, self.head_facing);
                }
            }

            self.facing *= -1;
        }
    }
    draw_set_alpha(1);
}

event_inherited();
