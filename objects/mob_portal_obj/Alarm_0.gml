/// @description  START EMITTING PARTICLES
if(enabled)
{
    if(active)
    {
        emit_particles = true;
        visible = true;
        invisible = false;
        alarm[1] = particles_time - siren_time;
    }
    else
    {
        alarm[0] = DB.mob_spawner_start_offset + first_spawn - particles_time;
        var count = instance_number(mob_portal_obj);
        DB.mob_spawner_start_offset += respawn_time/count;
        active = true;
    }
}


