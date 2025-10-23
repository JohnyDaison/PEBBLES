/// DEATH
event_inherited();

// OUT OF BOUNDS
var place = gamemode_obj.world.current_place;
if (self.y > place.y + place.height) {
    instance_destroy();
}

// DAMAGE
if (self.damage > self.hp) {
    instance_destroy();
    my_sound_play(wall_crumble_sound);
}
