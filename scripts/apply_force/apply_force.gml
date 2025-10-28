/// @param {Id.Instance} target
/// @param {Bool} repel
/// @param {Bool} ignore_my_stuff
/// @param {Real} coef
function apply_force(target, repel, ignore_my_stuff = false, coef = 1) {
    if (!instance_exists(target)) {
        return false;
    }
    
    var forceField = self.id;
    var force_sign = repel ? 1 : -1;

    if (ignore_my_stuff && 
        forceField.my_player == target.my_player && 
        forceField.my_player != noone && 
        forceField.my_player != gamemode_obj.environment) {
        return false;
    }

    var terrain_type = terrain_obj;

    if (object_is_child(target, projectile_obj) || target.object_index == slime_mob_obj) {
        terrain_type = solid_terrain_obj;
    }

    switch (forceField.shape) {
        case shape_circle:
            {
                var force_dir = point_direction(forceField.x, forceField.y, target.x, target.y);
                var dist = point_distance(forceField.x, forceField.y, target.x, target.y);
        
                if (dist == 0) {
                    break;
                }
        
                var dist_ratio = sqrt(forceField.field_focus / dist);
                var total_force = coef * force_sign * forceField.field_power * dist_ratio;
                var x_force = lengthdir_x(total_force, force_dir);
                var y_force = lengthdir_y(total_force, force_dir);
        
                var orig_x = target.x + target.hspeed;
                var orig_y = target.y + target.vspeed;
                var new_x = orig_x + x_force;
                var new_y = orig_y + y_force;
        
                with (target) {
                    if (!place_meeting(new_x, new_y, terrain_type)) {
                        target.hspeed += x_force;
                        target.vspeed += y_force;
                    }
                    else if (!place_meeting(new_x, orig_y, terrain_type)) {
                        target.hspeed += x_force;
                    }
                    else if (!place_meeting(orig_x, new_y, terrain_type)) {
                        target.vspeed += y_force;
        
                        if (object_is_child(forceField, structure_obj) && forceField.immovable
                            && object_is_child(target.id, phys_body_obj)
                            && sign(y_force) == -1) {
                            target.vspeed -= target.gravity;
                        }
                    }
                }
        
                if (target.speed > target.max_speed) {
                    target.speed = target.max_speed;
                }
            }

            break;

        case shape_rect:
            {
                var x_dist = target.x - forceField.x;
                var y_dist = target.y - forceField.y;

                var x_perim_dist = x_dist - sign(x_dist) * (forceField.width / 2);
                var y_perim_dist = y_dist - sign(y_dist) * (forceField.height / 2);
                
                var force_x = sign(x_dist);
                var force_y = sign(y_dist);

                if (sign(x_perim_dist) == sign(x_dist) && x_dist != 0) {
                    force_y = sign(y_dist) * sqrt(1 / abs(x_perim_dist));
                }

                if (sign(y_perim_dist) == sign(y_dist) && y_dist != 0) {
                    force_x = sign(x_dist) * sqrt(1 / abs(y_perim_dist));
                }

                var force_dir = point_direction(0, 0, force_x, force_y);
                var dist_ratio = point_distance(0, 0, force_x, force_y);

                var total_force = force_sign * forceField.field_power * dist_ratio;
                var new_x = target.x + target.hspeed + lengthdir_x(total_force, force_dir);
                var new_y = target.y + target.vspeed + lengthdir_y(total_force, force_dir);

                with (target) {
                    if (!place_meeting(new_x, new_y, terrain_type)) {
                        motion_add(force_dir, total_force);
                    }
                }
            }

            break;
    }

    if (repel) {
        my_sound_play(wall_hum_sound);
        //my_sound_play_colored(wall_hum_sound, my_color);
    }

    if (target.gives_light) {
        target.light_boost *= 1.4;
    }
}
