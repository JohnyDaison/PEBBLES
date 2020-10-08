var i;
for(i=0;i<4;i++)
{
    var gate = my_gates[?i];
    if(!is_undefined(gate) && instance_exists(gate))
    {
        gate.field[?(i+2 mod 4)] = noone;
    }
}
ds_map_destroy(my_gates);

my_sound_play(gate_off_sound);

event_inherited();
