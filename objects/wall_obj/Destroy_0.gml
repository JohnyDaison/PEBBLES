/// @description  DESTROY WILL_SPREAD MAP
ds_map_destroy(will_spread);

event_inherited();
/// DESTROY LAST_ATTACKER MAP
last_attacker_destroy();

// CREATE regenerator OBJECT
if (!cancelled && mod_get_state("regenerate_terrain") && cover != cover_grate) {
    var regen_obj = instance_create(xstart, ystart, wall_regenerator_obj);
    regen_obj.energy = orig_energy;
    regen_obj.my_color = orig_color;
    regen_obj.damage = orig_damage;
    regen_obj.color_locked = orig_locked;
}

// CREATE GRATE BLOCK
if (cover == cover_grate) {
    if (!instance_exists(grate)) {
        grate = instance_create(x, y, grate_block_obj);
        with(grate) {
            event_perform(ev_step, ev_step_begin);
        }
    }
}