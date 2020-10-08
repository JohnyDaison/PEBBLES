action_inherited();
/*
for(index=2;index<4;index+=1)
{
    if(joystick_exists(index-1))
    {
        players_pane.control_labels[index].icon = green_dot_spr;
        if(players_pane.unassign_buttons[index].enabled == false)
        {
            players_pane.assign_buttons[index].enabled = true;
        }    
    }
    else
    {
        players_pane.control_labels[index].icon = red_dot_spr;
        players_pane.assign_buttons[index].enabled = false;
        if(players_pane.unassign_buttons[index].enabled == true)
        {
            match_unassign_player();
            players_pane.unassign_buttons[index].enabled = false;  
        }
    }
}
*/

for(i=0;i<DB.limit_count;i+=1)
{
    limits_pane.limit_dials[i].enabled = limits_pane.limit_checkboxes[i].checked;
}
/*
if(match_pane.ban_black.checked)
{
    match_pane.starting_slots.min_value = 1;
}
else
{
    match_pane.starting_slots.min_value = 0;
}
*/

/* */
/*  */
