/// @description  ASSIGN BLOCK
var ter = instance_nearest(x-16,y-16,wall_obj);
var tc_x = ter.x+16;
var tc_y = ter.y+16;
var dist = point_distance(tc_x,tc_y,x,y);

if(dist == 0)
{
    x = tc_x -0.5;
    y = tc_y -0.5;
    my_block = ter;
}

