self.width = singleton_obj.current_width/7;
if(instance_exists(place_obj)) {
    self.height = self.width*(place_obj.height/place_obj.width);
}
else
{
    self.height = self.width*(room_height/room_width);
}
self.x = singleton_obj.player_port_width - width/2;
self.y = 0;

