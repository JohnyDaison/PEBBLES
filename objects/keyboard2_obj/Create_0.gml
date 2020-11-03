event_inherited();

input_id = keyboard2;

binds[? up] =  219;
binds[? down] =  222;
binds[? left] =  186;
binds[? right] =  220;
directions_str =
get_const_name(keyboard, binds[? up]) +
get_const_name(keyboard, binds[? left]) +
get_const_name(keyboard, binds[? down]) +
get_const_name(keyboard, binds[? right]);

binds[? r] =  vk_numpad6;
binds[? g] =  vk_numpad5;
binds[? b] =  vk_numpad4;
binds[? cast] =  vk_numpad8;
binds[? channel] =  vk_numpad7;
binds[? abi] =  vk_numpad9;
binds[? jump] =  vk_right;
binds[? look] =  vk_left;
binds[? altfire] =  vk_numpad2;
binds[? inventory_1] =  vk_numpad1;
binds[? inventory_2] =  vk_numpad2;
binds[? inventory_3] =  vk_numpad3;
binds[? inventory_4] =  vk_enter;
binds[? colorinfo] =  vk_pagedown;
