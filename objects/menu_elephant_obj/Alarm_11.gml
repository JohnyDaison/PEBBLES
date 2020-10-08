/// @description  ELEPHANT UPDATE
elephant_base1_x = -120;
elephant_base2_x = view_wport[0]+120;
elephant_y = view_hport[0]/2;
if(elephant_move_dir == 0)
{
    elephant_move_dir = -1;
    elephant_x = elephant_width/2; 
    alarm[11] = 1;
}
else 
{
    alarm[11] = 1;
    if(elephant_move_dir == -1)
    {
        elephant_x -= elephant_peek_speed;
        if(elephant_x <= - elephant_width/2)
        {
            elephant_move_dir = 1;
        }
    }
    else if(elephant_move_dir == 1)  
    {  
        elephant_x += elephant_hide_speed;
        if(elephant_x >= elephant_width/2)
        {
            elephant_move_dir = 0;
            alarm[11] = irandom_range(elephant_min_wait, elephant_max_wait);
        }
    }
}

