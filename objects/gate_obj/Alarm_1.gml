/// @description  ASSIGN BLOCK
var ter = instance_nearest(self.x - 16, self.y - 16, terrain_obj);
var tc_x = ter.x + 16;
var tc_y = ter.y + 16;
var dist = point_distance(tc_x, tc_y, self.x, self.y);

if (dist == 0) {
    self.my_block = ter;
    self.x--;
    self.y--;
}
else {
    instance_destroy();
}

/// ASSIGN PLAYER
var closest_spawner = get_closest_spawner(self.x, self.y, true);

if (instance_exists(closest_spawner) && instance_exists(closest_spawner.my_player)) {
    self.my_player = closest_spawner.my_player;
}
