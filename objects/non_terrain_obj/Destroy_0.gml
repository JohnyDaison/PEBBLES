if(instance_exists(chunkgrid_obj))
{
    chunk_deregister(chunkgrid_obj, id);
}

event_inherited();
