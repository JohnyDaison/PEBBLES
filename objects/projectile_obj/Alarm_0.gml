///@description SET UP FRICTION AND MODS
friction = orig_friction;

var be_heavy = mod_get_state("heavy_shots");

if(!be_heavy)
{
    if(object_is_child(my_guy, guy_obj) && my_guy.status_left[? "heavy_shots"] > 0)
    {
        be_heavy = true;
    }
}

if(be_heavy)
{
    orig_friction *= 2;
    friction = orig_friction;
    was_stopped = true;
    gravity_coef *= 10;
    gravity = gravity_coef;
}
