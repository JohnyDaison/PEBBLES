event_inherited();

var total_storage_orbs = 0;
var total_orb_light = 0;

// ROTATING ARROW
if(gamemode_obj.player_count == 1)
{
    rotating_arrow_image += rotating_arrow_speed;
    if(rotating_arrow_image >= rotating_arrow_image_count)
    {
        rotating_arrow_image = 0;   
    }

    if(rotating_arrow_alpha > rotating_arrow_alpha_min)
    {
        rotating_arrow_alpha -= rotating_arrow_alpha_decay;
        if(rotating_arrow_alpha < rotating_arrow_alpha_min)
        {
            rotating_arrow_alpha = rotating_arrow_alpha_min;
        }
    }
}

// ORB COUNT UPDATE
if(instance_exists(my_guy))
{
    for(col = g_red; col <= g_blue; col++)
    {
        if(col == g_yellow) continue;
        
        if(last_orbs[? col] != my_guy.orb_reserve[? col])
            orb_light[? col] = 1;
            
        last_orbs[? col] = my_guy.orb_reserve[? col];
        total_storage_orbs += last_orbs[? col];
    }    
    
    // ORB BELTS
    orb_panel_width = 0;
    for(col=g_dark; col<=g_blue; col++)
    {
        if(col == g_yellow) continue;

        var belt = my_guy.orb_belts[? col];
        if(ds_exists(belt,ds_type_list))
        {
            show_belt[? col] = true;
            //belt_list[? col] = belt;
            ds_list_copy(belt_list[? col], belt);
            for(var ii=my_guy.slot_number-1; ii>=0; ii--)
            {
                var orb = my_guy.color_slots[| ii];
                if(orb.my_color == col)
                {
                    ds_list_insert(belt_list[? col], 0, orb.id);
                }
            }
            orb_panel_width += orb_belt_width;
        }
        else
        {
            show_belt[? col] = false;
            ds_list_clear(belt_list[? col]);
        }
    }
}   

// ORB FADING    
for(col = g_red; col <= g_blue; col++)
{
    if(col == g_yellow) continue;
    
    if(orb_light[? col] > 0)
    {
        orb_light[? col] = max(0, orb_light[? col] - 0.01);
    }
    
    total_orb_light += orb_light[? col];
}

// ORB STORAGE HIDING
if(total_storage_orbs == 0 && total_orb_light == 0)
{
    hide_storage = true;
}
else
{
    hide_storage = false;
}

// ORBIT, BELTS AND ABILITIES BLINKING

if(chborbit_blink_time > 0)
{
    show_chargeball_orbit = ((chborbit_blink_time div chborbit_blink_rate) + 1) mod 2;

    chborbit_blink_time--;
}

if(belts_blink_time > 0)
{
    show_belts = ((belts_blink_time div belt_blink_rate) + 1) mod 2;
    
    belts_blink_time--;
}

if(abilities_blink_time > 0)
{
    show_abilities = ((abilities_blink_time div abilities_blink_rate) + 1) mod 2;
    
    abilities_blink_time--;
}
