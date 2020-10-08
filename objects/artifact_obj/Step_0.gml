event_inherited();

speed = min(speed, max_speed);

if(instance_exists(gamemode_obj.world.current_place))
{
    var place = gamemode_obj.world.current_place;
    
    if(x < place.x || y < place.y
    || x > place.x + place.width
    || y > place.y + place.height)
    {
        last_attacker_map[? "player"] = noone;
        instance_destroy();
    }
}
else
{
    if(x < 0 || y < 0
    || x > room_width
    || y > room_height)
    {
        last_attacker_map[? "player"] = noone;
        instance_destroy();
    }
}

