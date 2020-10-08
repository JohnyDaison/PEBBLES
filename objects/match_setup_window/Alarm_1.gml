for(i=0;i<DB.limit_count;i+=1)
{
    limit_checkbox = limits_pane.limit_checkboxes[i];
    limit_dial = limits_pane.limit_dials[i];

    limit_checkbox.right_hand_object = limit_dial.dial.id;
    limit_dial.dial.left_hand_object = limit_checkbox.id;
}

