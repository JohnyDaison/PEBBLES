/// @description tut_guide_teleport(waypoint);
/// @function tut_guide_teleport
/// @param waypoint
function tut_guide_teleport() {

    var waypoint = argument[0];

    pre_tp_x = x;
    pre_tp_y = y;
                            
    effect_create_above(ef_firework, x,y, 1, DB.colormap[? g_blue]);
    set_guy_facing((waypoint.x - x) > 0);

    x = waypoint.x;
    y = waypoint.y;
    last_x = x;
    last_y = y;

    // NEW, is OK ?
    /*
    npc_waypoint = waypoint.waypoint_id;
    npc_last_waypoint = npc_waypoint;
    */
                            
    speed = 0;
    jumping_charge = 0;
    wanna_jump = false;
    air_dashing = false;

    if(instance_exists(charge_ball))
    {
        /*
        charge_ball.x = x;
        charge_ball.y = y;
        */
    
        if(charge_ball.energy > 0)
        {
            charge_ball.charge = 0;
            charge_ball.firing = false;
        
            charging = false;
            casting = false;
            wanna_cast = false;
        }
    }

    effect_create_above(ef_firework, x,y, 1, DB.colormap[? g_blue]);

    if(my_tp_sound == noone || !audio_is_playing(my_tp_sound))
    {
        my_tp_sound = my_sound_play(tp_sound, true, 0.75);
    }

    has_tped = true;
    speech_stop(true);
    
    npc_stuck = false;

    /*
    has_spoken = false;
    has_autospoken = false;
    */

    // NEW, is OK ?
    /*
    grab_attention_done = false;
    demonstration_done = false;

    phase = 0;
    demonstration_done = false;
    */
}
