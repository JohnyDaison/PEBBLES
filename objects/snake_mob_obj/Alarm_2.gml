/// @description  MOVE
if(done_for)
{
    instance_destroy();
    exit;
}

var ter, structure, my_x, my_y, prev_x, prev_y, count, i;

prev_x = x;
prev_y = y;

if(travel_direction < 0)
{
    travel_direction += 360;
}
travel_direction = travel_direction mod 360;

x_step = round(lengthdir_x(32, travel_direction));
y_step = round(lengthdir_y(32, travel_direction));

// EATING
snake_mob_find_food();
        
if(instance_exists(eat_target) && eat_target.x == x+x_step && eat_target.y == y+y_step)
{
    cur_ter = eat_target;
    snake_mob_assemble(1);
    eat_target = noone;
    
    move_tries = 0;
    alarm[2] = travel_delay;
    exit;
}

// BLOCKED BY TERRAIN
ter = instance_nearest(x+x_step, y+y_step, terrain_obj);

if(instance_exists(ter))
{
    if(ter.x == x+x_step && ter.y == y+y_step)
    {
        if(ter.id != eat_target)
        {
            if(move_tries < max_move_tries)
            {
                if(move_tries < 2 && instance_exists(eat_target))
                {
                    var dir = point_direction(x,y, eat_target.x, eat_target.y);
                    var turn_dir = sign(angle_difference(dir, travel_direction));
                    if(turn_dir == 0)
                    {
                        turn_dir = blocked_dir;
                    }
                    travel_direction += turn_dir*90;
                }
                else
                {
                    travel_direction += blocked_dir*90;
                }
                x_step = lengthdir_x(32, travel_direction);
                y_step = lengthdir_y(32, travel_direction);
            
                move_tries += 1;
                alarm[2] = travel_delay;
            }
            else
            {
                done_for = true;
                alarm[2] = 1;
            }
            exit;
        }
    }
}

// BLOCKED BY STRUCTURE
my_x = x+x_step;
my_y = y+y_step;

structure = instance_place(my_x, my_y, structure_obj);

if(instance_exists(structure) && structure.my_block == noone) //point_distance(my_x, my_y, structure.x, structure.x) < (16 + structure.radius)
{
    if(move_tries < max_move_tries)
    {
        if(move_tries < 2 && instance_exists(eat_target))
        {
            var dir = point_direction(x,y, eat_target.x, eat_target.y);
            var turn_dir = sign(angle_difference(dir, travel_direction));
            if(turn_dir == 0)
            {
                turn_dir = blocked_dir;
            }
            travel_direction += turn_dir*90;
        }
        else
        {
            travel_direction += blocked_dir*90;
        }
        x_step = lengthdir_x(32, travel_direction);
        y_step = lengthdir_y(32, travel_direction);
        
        move_tries += 1;
        alarm[2] = travel_delay;
    }
    else
    {
        done_for = true;
        alarm[2] = 1;
    }
    exit;
}

//blocked_dir *= -1;

count = body_size;
// MOVEMENT        
chunk_deregister(chunkgrid_obj, id);

for(i = 0; i < count; i++)
{
    ter = ter_group.members[| i];
    if(!is_undefined(ter) && instance_exists(ter))
    {
        terrain_deregister(singleton_obj, ter);
        
        my_x = ter.x;
        my_y = ter.y;
        
        if(i == 0)
        {
            terrain_move(ter, x + x_step, y + y_step);
        
            x = ter.x;
            y = ter.y;
        }
        else
        {
            terrain_move(ter, prev_x, prev_y);
        }
        
        terrain_register(singleton_obj, ter);
        
        prev_x = my_x;
        prev_y = my_y;   
    }
}

chunk_register(chunkgrid_obj, id);

// DESTROY RUNAWAY SNAKES
if(point_distance(x,y, room_width/2, room_height/2) > max(room_width, room_height))
{
    done_for = true;
    alarm[2] = 1;
}
else
{
    move_tries = 0;
    alarm[2] = travel_delay;
}
