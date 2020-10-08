chunk_deregister(chunkgrid_obj, id);

snake_mob_disassemble(0);

with(ter_group)
{
    instance_destroy();
}

ds_map_destroy(transform_memory);

