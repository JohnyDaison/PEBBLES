var orb = instance_create(self.x, self.y, color_orb_obj);

orb.my_color = self.my_color;
//orb.my_guy = orb.id;
orb.color_added = true;
orb.airborne = true;
orb.duplicate_me = self.duplicate_me;

if (!is_undefined(self.draw_label)) {
    orb.draw_label = self.draw_label;
}

if (instance_exists(self.spawned_from) && self.spawned_from.spawned_item == self.id) {
    self.spawned_from.spawned_item = orb;
}

instance_destroy();
