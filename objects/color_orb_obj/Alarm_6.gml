/// @description  DRAIN WALLS AND SLIMES UPDATE
// TODO: THIS SHOULD COMPILE LIST OF ALL SOURCES AND THEN COMPUTE THE MAX OF THEM

self.alarm[6] = self.drain_update_delay;

if (self.my_guy != self.id && self.my_guy.channeling) {
    var max_energy = 0;
    self.drained_object = noone;

    for (var i = 0; i < self.ter_list_length; i++) {
        var ter = self.ter_list[| i];
        if (!is_undefined(ter) && instance_exists(ter) && ter.object_index == wall_obj) {
            if ((ter.my_color & self.my_color) && point_distance(self.x, self.y, ter.x + 15, ter.y + 15) < self.drain_radius) {
                if (ter.energy > max_energy) {
                    max_energy = ter.energy;
                    self.drained_object = ter.id;
                }
            }
        }
    }

    if (self.drained_object == noone) {
        var mob;
        with (slime_mob_obj) {
            mob = self.id;
            with (other) {
                if ((mob.my_color & self.my_color) && point_distance(self.x, self.y, mob.x, mob.y) < self.drain_radius) {
                    if (mob.energy > max_energy) {
                        max_energy = mob.energy;
                        self.drained_object = mob.id;
                    }
                }
            }
        }
    }
}
else {
    self.drained_object = noone;
    self.read_terrain = false;
    self.alarm[6] = -1;
}
