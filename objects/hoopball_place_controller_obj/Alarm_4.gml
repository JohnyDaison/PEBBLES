/// @description NEW BALL

if(!gamemode_obj.limit_reached && instance_exists(guy_obj))
{
    var inst = create_energy_ball(shield_generator_structure_obj, "artillery_shot", current_color, 2.1);
    inst.y -= ball_y_offset;
    var dir;
    switch(has_ball_number)
    {
        case 1:
            dir = 1;
            break;
        case 2:
            dir = -1;
            break;
        default:
            dir = choose(-1,1);
            break;
    }

    inst.hspeed = dir * random_range(0.25, 0.5);
    inst.vspeed = -1;
    inst.speed = 8;
    inst.gravity_coef = 0.4;
    inst.gravity = inst.gravity_coef;
    inst.orig_friction = 0.04;
    inst.ground_friction_multiplier = 3;
    inst.wall_bounce_damping = 0.2;
    inst.was_stopped = true;
    inst.tracked = true;
    inst.max_speed = 14;
    
    da_ball = inst;
}
else
{
    alarm[4] = ball_respawn_wait;
}