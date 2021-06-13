/// @description  DESTROY WILL_SPREAD MAP
ds_map_destroy(will_spread);

event_inherited();
/// DESTROY LAST_ATTACKER MAP
last_attacker_destroy();

// CREATE GRATE BLOCK
if (cover == cover_grate) {
    if (!instance_exists(grate)) {
        grate = instance_create(x, y, grate_block_obj);
        with(grate) {
            event_perform(ev_step, ev_step_begin);
        }
    }
}