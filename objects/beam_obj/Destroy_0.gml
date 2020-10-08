ds_list_destroy(beam_nodes);
if(instance_exists(beam_end))
{
    with(beam_end)
    {
        instance_destroy();
    }
}
if(instance_exists(my_guy) && !instance_exists(my_holder))
{
    if(object_is_ancestor(my_guy.object_index, guy_obj))
    {
        with(my_guy)
        {   
            casting = false;
            casting_beam = false;
            have_casted = true;
            alarm[0] = spell_cooldown;
        }
    }
    
    if(my_guy.object_index == beam_turret_mount_obj)
    {
        my_guy.charging = true;
    }
}

if(instance_exists(my_ball))
    my_ball.firing = false;

event_inherited();
