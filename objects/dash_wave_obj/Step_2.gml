if(start_step != singleton_obj.step_count || has_collided)
{
    fading_out = true;
}

if(fading_out)
{
    fade_ratio -= fade_speed;
    if(fade_ratio <= 0)
    {
        instance_destroy();
        exit;
    }
}

event_inherited();