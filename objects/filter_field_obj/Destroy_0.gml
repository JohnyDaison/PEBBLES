var i;
for(i=1;i<=2;i++)
{
    var proj = my_projectors[? i];
    if(!is_undefined(proj) && instance_exists(proj))
    {
        proj.my_field = noone;
        proj.alarm[2] = 2;
    }
}
ds_map_destroy(my_projectors);

my_sound_play(gate_off_sound);

event_inherited();
