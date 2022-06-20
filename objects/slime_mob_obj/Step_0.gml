/// CRAWL ON TERRAIN, JUMP OVER 1-BLOCK HOLES
event_inherited();

// TODO: optimize this using read_terrain

blocking_entity = noone;
near_edge = false;
inside_terrain = false;

if(energy <= 0 || energy > max_energy)
{
    damage = max(damage, hp);
}

var collision_terrain;

if(instance_exists(blocking_object))
{
    collision_terrain = instance_place(x, floor(y), blocking_object);
    blocking_terrain = instance_place(x + facing + hspeed, floor(y)-4, blocking_object);
    inside_terrain = instance_exists(collision_terrain);
}
else
{
    airborne = true;
    touching_terrain = false;
}


if(inside_terrain)
{
    speed = 0;
    
    var x_diff, y_diff, iter = 0;
    
    repeat(2)
    {
        if(iter != 0)
        {
            damage += inside_wall_damage;
            create_damage_popup(inside_wall_damage, my_color, id);
        }
        
        x_diff = collision_terrain.x+15 - x;
        y_diff = collision_terrain.y+15 - floor(y);
        
        if(x_diff == 0 && y_diff == 0)
        {
            y_diff = 1;
            x_diff = facing;
        }
        
        if(abs(x_diff) > abs(y_diff))
        {
            x -= 2*sign(x_diff);
        }
        else
        {
            y -= 2*sign(y_diff);
        }
        
        //show_debug_message("SLIME DMG:" + string(damage) + " HP: " + string(hp) + " " + "x_diff: " +string(round(x_diff)) + " y_diff: " +string(round(y_diff)));
        collision_terrain = instance_place(x, floor(y), blocking_object);       
        
        if(!instance_exists(collision_terrain))
        {
            break;
        }
        iter++;
    }
    blocking_terrain = instance_place(x + 2*facing, floor(y), blocking_object);
}
else
{
    my_head_grid_x = ((x + facing*radius) div 32) *32;
    //my_back_grid_x = ((x - facing*radius) div 32) *32;
    my_head_grid_y = (y div 32) *32;
    
    // TODO: this is not very optimal
    if(instance_exists(blocking_object))
    {
        body_terrain = instance_place(x, floor(y)+1, blocking_object);
        next_body_terrain = instance_place(((x+facing*32) div 32) *32 +15, floor(y)+1, blocking_object);
        jump_body_terrain = instance_place(((x+facing*64) div 32) *32 +15, floor(y)+1, blocking_object);
        jump_block_terrain = instance_place(((x+facing*64) div 32) *32 +15, floor(y)-16, blocking_object);
        
        //back_terrain = instance_nearest(my_back_grid_x, my_head_grid_y+32, blocking_object);
        head_terrain = instance_nearest(my_head_grid_x, my_head_grid_y+32, blocking_object);
        next_terrain = instance_nearest(my_head_grid_x + facing*47, my_head_grid_y +32, blocking_object);
        
        touching_terrain = instance_exists(body_terrain);
                    /*
                        || (instance_exists(head_terrain) && place_meeting(x,y+1, head_terrain))
                        || (instance_exists(back_terrain) && place_meeting(x,y+1, back_terrain));
                    */
    }
    
    inside_entity = place_meeting(x,y, phys_body_obj);
    blocking_entity = instance_place(x + facing, y, phys_body_obj);
    var movingThroughGrates = place_meeting(x,y, grate_block_obj);
    
    /*
    var y2_diff = next_terrain.bbox_top - bbox_bottom;
    var same_height = abs(y2_diff) <= 4;
    */
    
    // AIRBORNE
    if(airborne)
    {
        gravity = gravity_coef;
        friction = friction_air;
        turning = false;
        
        if (movingThroughGrates && speed > gratesMaxSpeed) {
            friction = frictionAirGrates;
        }
        
        if(jumping)
        {
            image_index = jump_sprite;
            if(vspeed > 0)
            {
                jumping = false;
            }
        }
        
        if(!jumping)
        {
            falling = true;
            image_index = fall_sprite;
        }
        
        if(touching_terrain || (instance_exists(blocking_entity) && !inside_entity))
        {
            speed = 0;
            /*
            if(!turning)
            {
                prepping = true;
                turning = true;
                alarm[2] = prep_time;
            }
            */
        }
        
        if(touching_terrain)
        {
            jumping = false;
            falling = false;
            airborne = false;
            
            y = floor(y);
            speed = 0;
            gravity = 0;
        }
    }
    else
    // GROUND
    {
        gravity = 0;
        friction = friction_ground;
        
        if(!touching_terrain)
        {
            resting = false;
            rested = false;
            prepping = false;
            prepped = false;
            crawling = false;
            airborne = true;
        }
        else
        {
            if(prepping)
            {
                friction *= 2;
            }
            
            if(!instance_exists(next_body_terrain))
            {
                near_edge = true;
            }
            
            // BLOCKED
            if(instance_exists(blocking_terrain) || (instance_exists(blocking_entity) && !inside_entity))
            {
                hspeed = 0;
                if(!turning)
                {
                    prepping = true;
                    turning = true;
                    rested = false;
                    crawling = false;
                    alarm[2] = prep_time;
                }
            }
            else
            {
                // NEAR EDGE
                if(near_edge)
                {
                    // CHECK TERRAIN UNDERHEAD
                    if(instance_exists(head_terrain) && instance_exists(next_terrain))
                    {
                        var jumpable = false;
                        var x2_diff = (next_terrain.x + 15) - (x + facing*radius);
                        
                        if((!instance_exists(jump_block_terrain))
                            && ( instance_exists(jump_body_terrain)
                                && (jump_body_terrain == next_terrain)
                                && !movingThroughGrates)
                            )
                        {
                            jumpable = true;
                        }
                        
                        if(jumpable)
                        {
                            if(!jumping && abs(x2_diff) < 48)
                            {
                                crawling = false;
                                prepped = false;
                                prepping = true;
                                jumping = true;
                                alarm[2] = prep_time;
                            }
                            else
                            {
                                crawling = true;
                            }
                        }
                        else
                        {
                            // TURN AROUND
                            if(!turning)
                            {
                                prepping = true;
                                turning = true;
                                rested = false;
                                crawling = false;
                                alarm[2] = prep_time;
                            }
                        }
                    }
                }
                else
                {
                    // FREE ROAM
                    crawling = true;
                }
                
                
                // JUMP
                if(jumping)
                {
                    if(prepped)
                    {
                        if(!instance_exists(jump_block_terrain))
                        {
                            hspeed += facing * jump_hboost;
                            vspeed -= jump_vboost;
                            image_index = takeoff_sprite;
                            rested = false;
                        }
                        else
                        {
                            if(!turning)
                            {
                                prepping = true;
                                turning = true;
                                rested = false;
                                crawling = false;
                                alarm[2] = prep_time;
                            }
                        }
                    }
                }
                // CRAWL
                else if(crawling)
                {  
                    // PREP
                    if(!prepped && !prepping && hspeed == 0)
                    {
                        prepping = true;
                        alarm[2] = prep_time;
                    }
                    
                    // CRAWL
                    if(prepped)
                    {
                        if(!instance_exists(blocking_terrain))
                        {
                            crawl_speed = crawlSpeedNormal;
                            if (movingThroughGrates) {
                                crawl_speed = crawlSpeedGrates;
                            }
                            
                            hspeed = crawl_speed*facing;
                            image_index = crawl_sprite;
                            rested = false;
                        }
                        else
                        {
                            vspeed -= 2;
                            hspeed -= facing;
                            if(!turning)
                            {
                                prepping = true;
                                turning = true;
                                rested = false;
                                crawling = false;
                                alarm[2] = prep_time;
                            }
                        }
                    }
                }
            }
        }
    }
    
    // TURN AROUND
    if(turning)
    {
        if(prepped)
        {
            facing *= -1;
            turning = false;  
            prepping = false; 
        }
        else
        {
            image_index = takeoff_sprite;
        }
    }
}

// SPEED CAP
if(speed > max_speed)
{
    speed = max_speed;
}
/*
name = "";

if(facing == 1)     name += "+" else name += "-";
if(inside_terrain)  name += "I" else name += " ";
if(airborne)        name += "A" else name += " ";
if(near_edge)       name += "N" else name += " ";
name += " ";
if(prepping)        name += "P" else name += " ";
if(prepped)         name += "D" else name += " ";
if(turning)         name += "T" else name += " ";
if(crawling)        name += "C" else name += " ";
if(jumping)         name += "J" else name += " ";
if(falling)         name += "F" else name += " ";

draw_label = true;
*/
if(prepping)
{
    if(!prepped && !rested && !resting)
    {
        alarm[2] = -1;
        resting = true;
        image_index = rest_sprite;
        alarm[3] = rest_time;
    }
    
    if(resting && rested)
    {
        resting = false;
        alarm[2] = prep_time;
    }
}

if(prepped)
{
    prepping = false;
    prepped = false;
}
if(prepping && rested)
{
    image_index = prep_sprite;
}

image_xscale = facing;

self.light_xoffset = sign(facing-1);

// FALL OUT OF ARENA
var place = gamemode_obj.world.current_place;
if(y > place.y + place.height)
{
    damage = max(damage, hp);   
}

// DEATH
if(damage >= hp)
{
    if(energy > 0)
    {
        var dir, cur_dir, dir_step = 360/self.slime_ball_count, xx, yy;
        
        for(dir = 0; dir<360; dir+=dir_step)
        {
            cur_dir = (dir + 270) mod 360;
            
            xx = lengthdir_x(1, cur_dir);
            yy = lengthdir_y(1, cur_dir);
            
            i = create_energy_ball(id, "slime_ball", my_color, self.energy/slime_ball_count); // radius 4
            i.my_guy = id;
            
            i.x = round(x + xx*radius);
            i.y = round(y + min(0, yy*radius));
                        
            i.direction = cur_dir;
            i.speed = 1.5;
            if(i.vspeed > 0)
            {
                i.vspeed = 0;
            }
            i.hspeed += hspeed;
            i.vspeed += vspeed;
        }
    }
    
    done_for = true;
    dead = true;
}

if(energy < 0)
{
    energy = 0;
}

final_tint = merge_colour(DB.colormap[? g_dark], tint, min(1, energy/base_energy));
ambient_light = ambient_light_coef*energy/base_energy;
direct_light = direct_light_coef*energy/base_energy;
