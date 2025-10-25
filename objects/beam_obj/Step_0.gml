event_inherited();

var last_node = ds_list_size(self.beam_nodes) - 1;

if (self.beam_head_node > last_node) {
    self.beam_head_node = last_node;
    self.beam_head_node_changed = true;
}

for (var nodeIndex = 0; nodeIndex <= last_node; nodeIndex += 1) {
    var node = self.beam_nodes[| nodeIndex];

    if (!instance_exists(node)) {
        self.alarm[0] = 1;
        self.invalid = true;
    }
}

if (self.endpoint_reached && !self.invalid) {
    if (self.head_facing == 0) {
        self.head_facing = self.facing_right ? 1 : -1;
    }

    if (self.beam_head_node_changed) {
        //show_debug_message("beam:"+string(beam_head_node)+" "+string(ds_list_size(beam_nodes)));
        self.head_node = self.beam_nodes[| self.beam_head_node];

        if (instance_exists(head_node)) {
            self.node_x = self.head_node.x;

            if (self.beam_head_node != last_node) {
                var next_node = self.beam_nodes[| self.beam_head_node + 1];
                self.next_node_x = next_node.x;

                if (object_is_ancestor(next_node.object_index, terrain_obj)) {
                    self.next_node_x += 16 - self.facing * 16;
                }

                if (next_node.object_index == shield_obj) {
                    self.next_node_x += -self.facing * next_node.radius;
                }
            }
            if (last_node == 0) {
                self.next_node_x = (1 + 1.1 * self.head_facing) * room_width / 2;
            }

            // PUSH
            if (!self.beam_head_landed) {
                var pushed_guy = noone;
                var head = self.head_node;

                if (object_is_ancestor(head.object_index, guy_obj)) {
                    pushed_guy = head;
                }

                if (head.object_index == shield_obj && instance_exists(head.my_guy) && object_is_ancestor(head.my_guy.object_index, guy_obj)) {
                    pushed_guy = head.my_guy;
                }

                if (pushed_guy != noone) {
                    if (pushed_guy != self.my_guy)
                        pushed_guy.hspeed -= self.head_facing * 4;
                    else
                        pushed_guy.hspeed -= self.head_facing;
                }
            }
        }

        self.beam_head_node_changed = false;
    }

    // BEAM HEAD PROPAGATION
    if (self.beam_head_fired) {
        if (!self.beam_head_landed) {
            self.beam_head_dist += (self.head_facing * self.beam_speed / 2);
            //show_debug_message("head_dist: " + string(self.beam_head_dist));
            if (sign(self.next_node_x - (self.node_x + self.beam_head_dist)) != self.head_facing) {
                if (self.beam_head_node + 1 < last_node) {
                    self.beam_head_node += 1;
                    self.beam_head_dist = 0;
                    self.head_facing *= -1;
                    show_debug_message("head_node: " + string(self.beam_head_node));
                    show_debug_message("head_facing: " + string(self.head_facing));
                    self.beam_head_node_changed = true;
                }
                else {
                    self.beam_head_dist = self.next_node_x - self.node_x;
                    self.beam_head_landed = true;
                }
            }
        }

        if (self.beam_head_landed && !instance_exists(self.beam_end)) {
            self.beam_end = instance_create(self.node_x + self.beam_head_dist, self.y, beam_end_obj);
            self.beam_end.my_beam = self.id;
        }

        if (self.beam_head_landed && instance_exists(self.beam_end)) {
            if (self.beam_head_node == last_node && last_node >= 1) {
                self.beam_head_dist = self.next_node_x - self.node_x;
            }

            self.beam_end.x = self.head_node.x + self.beam_head_dist;
            self.beam_end.y = self.head_node.y;

            if (object_is_ancestor(self.head_node.object_index, terrain_obj)) {
                self.beam_end.x += 16 - self.facing * 16;
                self.beam_end.y += 16;
            }
        }

        if (abs(self.beam_head_dist) > 0 || self.beam_head_node > 0) {
            self.force -= 0.01;
        }
    }

    if (self.force < self.fadeOutStart) {
        self.image_alpha -= 0.02;
        self.beam_alpha -= 0.02;
    }

    var beam = self;

    // DAMAGE DEALING
    if (self.force > 0) {
        self.updateFacing();

        // BEAM GOES OUTSIDE ROOM
        if (!self.collided) {
            var node = self.beam_nodes[| 0];
            var outsideRoomX = node.x + (1 + 1.1 * beam.facing) * room_width / 2;
            var beamHeadX = node.x + beam.beam_head_dist;
            var bigBeamTopY = node.y - beam.beam_big_core_size / 2;
            var bigBeamBottomY = node.y + beam.beam_big_core_size / 2;
            var smallBeamTopY = node.y - beam.beam_small_core_size / 2;
            var smallBeamBottomY = node.y + beam.beam_small_core_size / 2;

            if (self.beam_head_fired) {
                with (phys_body_obj) {
                    if (self.my_player != beam.my_player) {
                        if (collision_rectangle(node.x, bigBeamTopY, beamHeadX, bigBeamBottomY, self.id, false, false) != noone) {
                            receive_damage(beam.force / beam.big_beam_coef, true);
                        }
                    }
                }

                with (artifact_obj) {
                    if (collision_rectangle(node.x, bigBeamTopY, beamHeadX, bigBeamBottomY, self.id, false, false) != noone) {
                        receive_damage(beam.force / beam.big_beam_coef, true);
                        event_perform(ev_other, ev_user1);
                    }
                }

                with (crystal_obj) {
                    if (collision_rectangle(node.x, bigBeamTopY, beamHeadX, bigBeamBottomY, self.id, false, false) != noone) {
                        receive_damage(beam.force / beam.big_beam_coef, true);
                        event_perform(ev_other, ev_user1);
                    }
                }

            }

            if (!self.beam_head_landed) {
                with (phys_body_obj) {
                    if (self.my_player != beam.my_player) {
                        if (collision_rectangle(beamHeadX, smallBeamTopY, outsideRoomX, smallBeamBottomY, self.id, false, false) != noone) {
                            receive_damage(beam.force / beam.small_beam_coef, false);
                        }
                    }
                }

                with (artifact_obj) {
                    if (collision_rectangle(beamHeadX, smallBeamTopY, outsideRoomX, smallBeamBottomY, self.id, false, false) != noone) {
                        receive_damage(beam.force / beam.small_beam_coef, false);
                        event_perform(ev_other, ev_user1);
                    }
                }

                with (crystal_obj) {
                    if (collision_rectangle(beamHeadX, smallBeamTopY, outsideRoomX, smallBeamBottomY, self.id, false, false) != noone) {
                        receive_damage(beam.force / beam.small_beam_coef, false);
                        event_perform(ev_other, ev_user1);
                    }
                }
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

                    if (!instance_exists(next_node)) {
                        break;
                    }

                    if (object_is_ancestor(next_node.object_index, terrain_obj)) {
                        next_node_fix = 16 - self.facing * 16;
                    }

                    if (next_node.object_index == shield_obj) {
                        next_node_fix = -self.facing * next_node.radius;
                    }
                    
                    var nodeFixedX = node.x + node_fix;
                    var nextNodeFixedX = next_node.x + next_node_fix;
                    var beamHeadFixedX = nodeFixedX + beam.beam_head_dist;
                    var bigBeamTopY = node.y - beam.beam_big_core_size / 2;
                    var bigBeamBottomY = node.y + beam.beam_big_core_size / 2;
                    var smallBeamTopY = node.y - beam.beam_small_core_size / 2;
                    var smallBeamBottomY = node.y + beam.beam_small_core_size / 2;

                    if (self.beam_head_fired) {
                        if (nodeIndex < self.beam_head_node) {
                            with (phys_body_obj) {
                                if (self.my_player != beam.my_player) {
                                    if (collision_rectangle(nodeFixedX, bigBeamTopY, nextNodeFixedX, bigBeamBottomY, self.id, false, false) != noone) {
                                        receive_damage(beam.force / beam.big_beam_coef, true);
                                    }
                                }
                            }

                            with (artifact_obj) {
                                if (collision_rectangle(nodeFixedX, bigBeamTopY, nextNodeFixedX, bigBeamBottomY, self.id, false, false) != noone) {
                                    receive_damage(beam.force / beam.big_beam_coef, true);
                                    event_perform(ev_other, ev_user1);
                                }
                            }

                            with (crystal_obj) {
                                if (collision_rectangle(nodeFixedX, bigBeamTopY, nextNodeFixedX, bigBeamBottomY, self.id, false, false) != noone) {
                                    receive_damage(beam.force / beam.big_beam_coef, true);
                                    event_perform(ev_other, ev_user1);
                                }
                            }
                        }

                        if (nodeIndex > self.beam_head_node) {
                            with (phys_body_obj) {
                                if (self.my_player != beam.my_player) {
                                    if (collision_rectangle(nodeFixedX, smallBeamTopY, nextNodeFixedX, smallBeamBottomY, self.id, false, false) != noone) {
                                        receive_damage(beam.force / beam.small_beam_coef, false);
                                    }
                                }
                            }

                            with (artifact_obj) {
                                if (collision_rectangle(nodeFixedX, smallBeamTopY, nextNodeFixedX, smallBeamBottomY, self.id, false, false) != noone) {
                                    receive_damage(beam.force / beam.small_beam_coef, false);
                                    event_perform(ev_other, ev_user1);
                                }
                            }

                            with (crystal_obj) {
                                if (collision_rectangle(nodeFixedX, smallBeamTopY, nextNodeFixedX, smallBeamBottomY, self.id, false, false) != noone) {
                                    receive_damage(beam.force / beam.small_beam_coef, false);
                                    event_perform(ev_other, ev_user1);
                                }
                            }
                        }

                        if (nodeIndex == self.beam_head_node) {
                            with (phys_body_obj) {
                                if (self.my_player != beam.my_player) {
                                    if (collision_rectangle(nodeFixedX, bigBeamTopY, beamHeadFixedX, bigBeamBottomY, self.id, false, false) != noone) {
                                        receive_damage(beam.force / beam.big_beam_coef, true);
                                    }

                                    if (sign(next_node.x - beam.beam_head_dist) == beam.head_facing) {
                                        if (collision_rectangle(beamHeadFixedX, smallBeamTopY, nextNodeFixedX, smallBeamBottomY, self.id, false, false) != noone) {
                                            receive_damage(beam.force / beam.small_beam_coef, false);
                                        }
                                    }
                                }
                            }

                            with (artifact_obj) {
                                if (collision_rectangle(nodeFixedX, bigBeamTopY, beamHeadFixedX, bigBeamBottomY, self.id, false, false) != noone) {
                                    receive_damage(beam.force / beam.big_beam_coef, true);
                                    event_perform(ev_other, ev_user1);
                                }

                                if (sign(next_node.x - beam.beam_head_dist) == beam.head_facing) {
                                    if (collision_rectangle(beamHeadFixedX, smallBeamTopY, nextNodeFixedX, smallBeamBottomY, self.id, false, false) != noone) {
                                        receive_damage(beam.force / beam.small_beam_coef, false);
                                        event_perform(ev_other, ev_user1);
                                    }
                                }
                            }

                            with (crystal_obj) {
                                if (collision_rectangle(nodeFixedX, bigBeamTopY, beamHeadFixedX, bigBeamBottomY, self.id, false, false) != noone) {
                                    receive_damage(beam.force / beam.big_beam_coef, true);
                                    event_perform(ev_other, ev_user1);
                                }

                                if (sign(next_node.x - beam.beam_head_dist) == beam.head_facing) {
                                    if (collision_rectangle(beamHeadFixedX, smallBeamTopY, nextNodeFixedX, smallBeamBottomY, self.id, false, false) != noone) {
                                        receive_damage(beam.force / beam.small_beam_coef, false);
                                        event_perform(ev_other, ev_user1);
                                    }
                                }
                            }
                        }
                    }
                    else {
                        with (phys_body_obj) {
                            if (self.my_player != beam.my_player) {
                                if (collision_rectangle(nodeFixedX, smallBeamTopY, nextNodeFixedX, smallBeamBottomY, self.id, false, false) != noone) {
                                    receive_damage(beam.force / beam.small_beam_coef, false);
                                }
                            }
                        }

                        with (artifact_obj) {
                            if (collision_rectangle(nodeFixedX, smallBeamTopY, nextNodeFixedX, smallBeamBottomY, self.id, false, false) != noone) {
                                receive_damage(beam.force / beam.small_beam_coef, false);
                                event_perform(ev_other, ev_user1);
                            }
                        }

                        with (crystal_obj) {
                            if (collision_rectangle(nodeFixedX, smallBeamTopY, nextNodeFixedX, smallBeamBottomY, self.id, false, false) != noone) {
                                receive_damage(beam.force / beam.small_beam_coef, false);
                                event_perform(ev_other, ev_user1);
                            }
                        }
                    }
                }

                self.facing *= -1;
            }
        }
    }
}

var shooter = self.my_guy;

if (instance_exists(shooter) && object_is_ancestor(shooter.object_index, guy_obj)) {
    if (shooter.lost_control) {
        self.my_holder = instance_create(self.x, self.y, place_holder_obj);
        ds_list_replace(self.beam_nodes, 0, self.my_holder.id);

        if (self.force > self.fadeOutStart) {
            self.force = self.fadeOutStart;
        }

        self.finishCasting(shooter);
        shooter.charge_ball.firing = false;
    }
}

if (instance_exists(self.my_ball)) {
    self.my_ball.charge = self.force;
}

if (self.force <= 0) {
    instance_destroy();
}
