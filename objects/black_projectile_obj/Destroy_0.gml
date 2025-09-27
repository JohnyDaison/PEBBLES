if (instance_number(self.object_index) == 1) {
    my_sound_stop(black_projectile_sound);
}

// give guys normal gravity
with (guy_obj) {
    if (self.id != other.my_guy) {
        if (self.holographic == other.holographic && (self.gravity_coef != self.old_coef || gravity_direction != 270)) {
            self.gravity_direction = 270;
            self.gravity_coef = self.old_coef;
            self.y -= 1;
            self.airborne = false;
        }
    }
}

self.explosion_count = 0;

// explode slots
for (var i = 0; i < self.slot_count; i += 1) {
    var slot = self.stolen_slots[| i];
    if (instance_exists(slot)) {
        if (slot.my_guy == self.id) {
            if (slot.my_color == g_dark) {
                var inst = instance_create(self.x, self.y, black_aoe_obj);
                //inst.my_player = my_guy.my_player;
                inst.force = self.force;
                inst.my_color = self.my_color;
                inst.my_guy = inst.id;
                inst.holographic = self.holographic;
                with (slot) {
                    instance_destroy();
                }
                self.explosion_count += 1;
            }
            else {
                var inst = instance_create(self.x, self.y, slot_explosion_obj);
                inst.slot = slot.id;
                inst.my_source = slot.object_index;
                inst.holographic = self.holographic;
                slot.my_guy = inst.id;
                self.explosion_count += 1;
            }
        }
    }
}

// if slots exploded, destroy unclaimed pickups
if (self.explosion_count > 0) {
    for (var i = 0; i < self.pickup_count; i += 1) {
        var pickup = self.picked_pickups[| i];
        if (instance_exists(pickup) && (!pickup.collected || (pickup.placed && pickup.stuck_to == noone))) {
            with (pickup) {
                instance_destroy();
            }
        }
    }
}

ds_list_destroy(self.stolen_slots);
ds_list_destroy(self.picked_pickups);

event_inherited();
