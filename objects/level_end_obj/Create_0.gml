event_inherited();

angle = 0;
scale = 1;
for_player = -1;

// EXIT ANIMATION
preparing = false;
prepared = false;
was_prepared = false;
exit_anim_start = -1;
prepare_anim_phase = 0;
exit_anim_step_time = 15;
exit_anim_prepare_time = 45;
exit_anim_exit_time = 90;
exit_anim_shutdown_time = 45;
exit_anim_length = exit_anim_prepare_time
                 + exit_anim_exit_time
                 + exit_anim_shutdown_time;
                 
object_exit_step = ds_map_create();

/*
trigger_script = levelend_trigger_script;
triggerable = true;
*/

depth = 15;