/// DEATH
event_inherited();

// OUT OF BOUNDS
var place = gamemode_obj.world.current_place;
if(y > place.y + place.height)
{
    instance_destroy();
}

// DAMAGE
if(damage > hp)
{
    instance_destroy();
    my_sound_play(wall_crumble_sound);
}

