event_inherited();

self.speed = min(self.speed, self.max_speed);

if (instance_exists(gamemode_obj.world.current_place)) {
    var place = gamemode_obj.world.current_place;

    if (self.x < place.x || 
        self.y < place.y ||
        self.x > place.x + place.width ||
        self.y > place.y + place.height) {
        self.last_attacker_map[? "player"] = noone;
        instance_destroy();
    }
}
else {
    if (self.x < 0 || 
        self.y < 0 ||
        self.x > room_width ||
        self.y > room_height) {
        self.last_attacker_map[? "player"] = noone;
        instance_destroy();
    }
}
