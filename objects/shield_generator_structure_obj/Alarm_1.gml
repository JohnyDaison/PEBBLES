/// @description  ASSIGN HOLDER

var ter = instance_nearest(x-16,y-16,terrain_obj);
var tc_x = ter.x+16;
var tc_y = ter.y+16;
var dist = point_distance(tc_x,tc_y, x,y);
//var dir = point_direction(tc_x,tc_y, x,y);

if(dist == 0)
{
    my_block = ter;
    my_holder = ter;
    x--;
    y--;
}
/*
if(my_holder == noone)
{
    var ter = instance_nearest(x,y, access_terminal_obj);
    var tc_x = ter.x;
    var tc_y = ter.y;
    var dist = point_distance(tc_x,tc_y, x,y);
    //var dir = point_direction(tc_x,tc_y, x,y);

    if(dist == 0)
    {
        my_struct = ter;
        my_holder = ter;
    }
}
*/

if(my_holder == noone)
{
    instance_destroy();
}

