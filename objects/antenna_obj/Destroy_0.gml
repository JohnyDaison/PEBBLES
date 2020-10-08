ds_map_destroy(enabled);
ds_map_destroy(lightning_dist);

for(var i=0; i<4; i++)
{
    if(instance_exists(light_emitter[? i]))
    {
        instance_destroy(light_emitter[? i]);
    }
}

ds_map_destroy(light_emitter);


event_inherited();
