event_inherited();

if(inv_size == -1)
{
    inv_size = my_guy.inventory_size;
    var i;

    for(i=1; i <= inv_size; i++)
    {
        bg_tint[? i] = c_white;
        blink_tint[? i] = c_white;
        blink_start[? i] = -1;
        last_pickup[? i] = noone;
        last_stacksize[? i] = 0;
    }
}
else
{
    for(i=1; i <= inv_size; i++)
    {
        //bg_tint[?i] = merge_colour(bg_tint[?i], c_white, 1/160);
        if(singleton_obj.step_count - blink_start[? i] > blink_length)
        {
            blink_start[? i] = -1;
        }
        
        if(blink_start[? i] == -1)
        {
            bg_tint[?i] = c_white;    
        }
        else
        {
            bg_tint[? i] = merge_color(c_white, blink_tint[? i], 0.42);
            
            if((singleton_obj.step_count div blink_tick) mod 2 == 0)
            {
                bg_tint[? i] = blink_tint[? i];    
            }
        }
    }
    
    // BLINK WHOLE INVENTORY
    if(whole_inv_blink_time > 0)
    {
        draw_inventory = ((whole_inv_blink_time div whole_inv_blink_rate) + 1) mod 2;
    
        whole_inv_blink_time--;
    }
}

if(instance_exists(my_guy))
{
    my_guy.full_inv_blink = false;
}