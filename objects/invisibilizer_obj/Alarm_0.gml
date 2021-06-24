var inst_list = ds_list_create();
instance_place_list(x, y, game_obj, inst_list, false);
var inst_count = ds_list_size(inst_list);

for(var inst_index = 0; inst_index < inst_count; inst_index++)
{
    var instance = inst_list[| inst_index];
    instance.invisible = invisible;
}

ds_list_destroy(inst_list);

instance_destroy();