if (instance_exists(self.my_guy) && self.my_guy != self.id) {
    body_unequip(self.my_guy, self.hardpoint);
}

last_attacker_destroy();

event_inherited();
