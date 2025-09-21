with (guy_obj) {
    if (self.id != other.my_guy) {
        // RETURN GRAVITY BACK TO NORMAL
        if (self.holographic == other.holographic && (self.gravity_coef != self.old_coef || self.gravity_direction != 270)) {
            self.gravity_direction = 270;
            self.gravity_coef = self.old_coef;
            self.y -= 1;
            self.airborne = false;
        }
    }
    else {
        self.casting = false;
        self.casting_ring = false;
        self.have_casted = true;
        self.alarm[0] = self.spell_cooldown;
    }
}

for (var i = self.slot_count - 1; i >= 0; i--) {
    var slot = self.stolen_slots[| i];

    if (instance_exists(slot)) {
        if (slot.my_guy == id) {
            slot.my_guy = slot.id;
            slot.airborne = true;
        }
    }
}

ds_list_destroy(self.stolen_slots);

event_inherited();
