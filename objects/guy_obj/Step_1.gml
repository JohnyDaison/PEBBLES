ds_list_clear(attack_waypoints);

event_inherited();

if(!flashback_disabled && !flashback_inited)
{
    ds_map_add(state,"x",x);
    ds_map_add(state,"y",y);
    ds_map_add(state,"speed",speed);
    ds_map_add(state,"direction",direction);
    ds_map_add(state,"sprite_index",0);
    ds_map_add(state,"image_index",0);
    ds_map_add(state,"tint",c_white);
    ds_map_add(state,"facing",1);
    ds_map_add(state,"airborne",airborne);
    ds_map_add(state,"my_color",my_color);
    ds_map_add(state,"damage",damage);
    
    flashback_inited = true;
}
