/// @description  ASSIGN BLOCK
var ter = instance_nearest(self.x - 16, self.y - 16, terrain_obj);
var tc_x = ter.x + 16;
var tc_y = ter.y + 16;
var dist = point_distance(tc_x, tc_y, self.x, self.y);

if (dist == 0) {
    self.my_block = ter;
    self.x--;
    self.y--;
    self.my_block.has_pusher = true;
}
else {
    instance_destroy();
}
