/// @description ASSIGN PLAYER
if (self.my_player != gamemode_obj.environment) {
    exit;
}

var closest_spawner = get_closest_spawner(self.x, self.y, true);

if (!instance_exists(closest_spawner) || !instance_exists(closest_spawner.my_player)) {
    exit;
}

self.my_player = closest_spawner.my_player;
self.my_team_number = self.my_player.team_number;
self.flag_icon = self.my_player.icon;
