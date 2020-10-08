/// @description  BEAM UPDATE
if(instance_exists(my_ball))
{
    x = my_ball.x;
    y = my_ball.y;
    //facing_right = my_guy.facing_right;
}

ds_list_clear(beam_nodes); 

if(!instance_exists(my_holder))
{
    last_obj = my_ball;
}
else
{
    last_obj = my_holder;
}

// ADD LAST OBJ
if(instance_exists(last_obj))
    ds_list_add(beam_nodes,last_obj.id);
else
{
    instance_destroy();
    exit;
}

// FACING
if(facing_right)
    facing = 1;
else
    facing = -1;

// BEAM EDGES
if(!beam_head_fired)
{    
    beam_top = y - beam_small_core_size/2;
    beam_bottom = y + beam_small_core_size/2;
}
else
{
    beam_top = y - beam_big_core_size/2;
    beam_bottom = y + beam_big_core_size/2;
}


endpoint_reached = false;
beam_point = last_obj.x;  
collided = false;

while(!endpoint_reached)
{
    step_resolved = false;
    
    shields_found = 0;
    shields[0] = noone;
    correct_shield = noone;
    
    walls_found = 0;
    walls[0] = noone;
    correct_wall = noone;
    
    // SHIELDS
    with(shield_obj)
    {
        if(sign(x - other.beam_point) == other.facing && y+radius > other.beam_top && y-radius < other.beam_bottom && id != other.last_obj && my_color == other.my_color)
        {
            other.shields[other.shields_found] = id;
            other.shields_found += 1;
        }
    }
    //show_debug_message("found shields: "+string(shields_found));
    
    if(shields_found == 1)
        correct_shield = shields[0];
    else if(shields_found > 1)
    {   
        closest_x = facing*room_width;
        for(i=0;i<shields_found;i+=1)
        {
            var shield = shields[i];
            if(sign(closest_x - (shield.x - self.facing * shield.radius)) == facing)
            {
                closest_x = shield.x - self.facing*shield.radius;
                correct_shield = shield;
            }
        }
    }

    // WALLS
    with(terrain_obj)
    {
        if(object_index != grate_block_obj)
        {
            if(sign(x - other.beam_point) == other.facing && y+32 > other.beam_top && y < other.beam_bottom)
            {
                other.walls[other.walls_found] = id;
                other.walls_found += 1;
            }
        }
    }
    //show_debug_message("found walls: "+string(walls_found));
    
    if(walls_found == 1)
        correct_wall = walls[0];
    else if(walls_found > 1)
    {   
        closest_x = facing*room_width;
        for(i=0;i<walls_found;i+=1)
        {
            if(sign(closest_x-(walls[i]).x) == facing)
            {
                closest_x = (walls[i]).x;
                correct_wall = walls[i];
            }
        }
    }
    
    // FINALIZING
    //show_debug_message("final");
    if(correct_wall != noone && correct_shield != noone && !step_resolved)
    {  
        if(sign(correct_shield.x-correct_wall.x) == facing)
        {
            ds_list_add(beam_nodes,correct_wall);
            endpoint_reached = true;
            step_resolved = true;
            collided = true;
        }
    }
    
    if(correct_shield != noone && !step_resolved)
    {
        if(ds_list_find_index(beam_nodes,correct_shield) == -1)
        {
            ds_list_add(beam_nodes,correct_shield);
            facing *= -1;
            beam_point = correct_shield.x+facing*correct_shield.radius;
            last_obj = correct_shield;
            step_resolved = true;
            collided = true;
        }
        else
        {
            ds_list_add(beam_nodes,correct_shield);
            endpoint_reached = true;
            step_resolved = true;
            collided = true;
        }
    }
    
    if(correct_wall != noone && !step_resolved)
    {
        ds_list_add(beam_nodes,correct_wall);
        endpoint_reached = true;
        step_resolved = true;
        collided = true;
    }
    
    if(correct_wall == noone && correct_shield == noone && !step_resolved)
    {
        endpoint_reached = true;
        step_resolved = true;
    }
}

beam_head_node_changed = true;
invalid = false;
alarm[0] = beam_update_delay;

