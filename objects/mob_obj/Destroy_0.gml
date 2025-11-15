var mob = self;

with (spell_obj) {
    var spell = self;

    if (spell.my_guy == mob.id) {
        spell.my_guy = spell.id;
    }
}

destroy_equipment_sys();

event_inherited();
