/// @description  ASSIGN BLOCK
var ter = instance_nearest(self.x - 16, self.y - 16, wall_obj);
var tc_x = ter.x + 16;
var tc_y = ter.y + 16;
var dist = point_distance(tc_x, tc_y, self.x, self.y);

if (dist == 0) {
    self.x = tc_x - 0.5;
    self.y = tc_y - 0.5;
    self.my_block = ter;
}
