/// @description STOP SIREN, SPAWN MOB
my_sound_stop(siren_sound);
emit_particles = false;
var inst, params;

if(enabled)
{
    if(spawn_sprinkler)
    {
        inst = instance_create(x,y, sprinkler_body_obj);
        params = create_params_map();
        params[? "mob"] = inst;
        broadcast_event("mob_spawn", id, params);
    }
    
    if(spawn_spitters)
    {
        repeat(irandom_range(3, 5))
        {
            instance_create(x,y, spitter_body_obj);
        }
    }    
    
    alarm[0] = respawn_time - particles_time;
    visible = false;
    invisible = true;
}

