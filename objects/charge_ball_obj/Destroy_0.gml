my_sound_stop(self.my_charge_sound);

part_emitter_destroy(self.system, self.em);
part_type_destroy(self.pt);
part_system_destroy(self.system);

for (var i = self.orb_count - 1; i >= 0; i--) {
    var orb = self.orbs[| i];
    instance_destroy(orb);
}

ds_list_destroy(self.orbs);

event_inherited();
