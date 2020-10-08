/// @description  ASSIGN HOLDER

var ter = instance_nearest(x-16,y-16,terrain_obj);
if (instance_exists(ter))
{
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
}

if(my_holder == noone)
{
    var structure = instance_nearest(x,y, access_terminal_obj);
    if (instance_exists(structure))
    {
        var tc_x = structure.x;
        var tc_y = structure.y;
        var dist = point_distance(tc_x,tc_y, x,y);
        //var dir = point_direction(tc_x,tc_y, x,y);

        if(dist == 0)
        {
            my_struct = structure;
            my_holder = structure;
        }
    }
}

if(my_holder == noone)
{
    var structure = instance_nearest(x,y, quest_detector_obj);
    if (instance_exists(structure))
    {
        var tc_x = structure.x;
        var tc_y = structure.y;
        var dist = point_distance(tc_x,tc_y, x,y);
        //var dir = point_direction(tc_x,tc_y, x,y);

        if(dist == 0)
        {
            my_struct = structure;
            my_holder = structure;
        }
    }
}

if(my_holder == noone)
{
    instance_destroy();
}

