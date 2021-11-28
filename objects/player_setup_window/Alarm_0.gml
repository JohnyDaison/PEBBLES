var gm = DB.gamemodes[? gamemode_obj.mode];
// PLAYER PANES
for(var pl_num = 1; pl_num <= players_pane.player_pane_count; pl_num++)
{
    var pane = player_panes_map[? pl_num];
    
    with(pane)
    {
        // UPDATE CONTROL DROPDOWN LISTS
        if(instance_exists(control_dropdown.list_picker))
        {
            ds_list_clear(controls_names);
            ds_list_clear(controls_ids);
            
            var count = ds_list_size(DB.control_set_order), i, control_id, name;
            
            for(i = 0; i < count; i++)
            {
                control_id = DB.control_set_order[| i];
                
                if(control_id == cpu_control_set && pl_num <= gm[? "min_real_players"])
                {
                    continue;
                }
                
                name = DB.control_set_names[| control_id];
                
                ds_list_add(controls_names, name);
                ds_list_add(controls_ids, control_id);
            }
            
            gui_list_picker_items_reset(control_dropdown.list_picker, "text", controls_names, controls_ids);
            
        }
    }
}