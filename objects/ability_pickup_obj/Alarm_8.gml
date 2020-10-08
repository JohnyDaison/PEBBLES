/// @description  UPDATE BASED ON COLOR
invisible = false;
visible = true;
tint_updated = false;
sprite_index = DB.abi_icons[? my_color];
self.name = DB.abi_name_map[? my_color];
if(target_level > 1)
{
    self.name += " " + string(target_level);   
}
self.description = DB.abi_description_map[? my_color];
self.abi_key = DB.abimap[? my_color];
self.levels[? abi_key] = target_level;
self.pickup_sound = slot_absorbed_sound;

