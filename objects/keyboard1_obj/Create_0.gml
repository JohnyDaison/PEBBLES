event_inherited();

input_id = keyboard1;

binds[? up] =  ord("W");
binds[? down] =  ord("S");
binds[? left] =  ord("A");
binds[? right] =  ord("D");
directions_str =
get_const_name(keyboard, binds[? up]) +
get_const_name(keyboard, binds[? left]) +
get_const_name(keyboard, binds[? down]) +
get_const_name(keyboard, binds[? right]);

binds[? b] =  ord("H");
binds[? g] =  ord("J");
binds[? r] =  ord("K");
binds[? cast] =  ord("U");
binds[? channel] =  ord("G");
binds[? abi] =  ord("I");
binds[? jump] =  vk_space;
binds[? look] =  vk_lshift;
binds[? altfire] =  ord("Y");
binds[? inventory_1] =  ord("1");
binds[? inventory_2] =  ord("2");
binds[? inventory_3] =  ord("3");
binds[? inventory_4] =  ord("4");
binds[? colorinfo] =  ord("N");

