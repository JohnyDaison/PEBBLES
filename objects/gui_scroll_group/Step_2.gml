list_count = ds_list_size(scroll_lists);
if(list_count > 1)
{
    for(i=0;i<list_count && (cur_item == new_cur_item) && (highlighted_item == new_high_item);i+=1)
    {
        list = ds_list_find_value(scroll_lists,i);
        if(list.cur_item != -1 && list.cur_item != cur_item)
        {
            new_cur_item = list.cur_item;
        }
        if(list.selection_pos != sel_pos)
        {
            new_sel_pos = list.selection_pos;
        }
        if(list.first_item != first_item)
        {
            new_first_item = list.first_item;
        }
        if(list.highlighted_item != highlighted_item)
        {
            new_high_item = list.highlighted_item;
        }
    }
    
    for(i=0;i<list_count;i+=1)
    {
        list = ds_list_find_value(scroll_lists,i);
        if(cur_item != new_cur_item)
        {
            list.cur_item = new_cur_item;
            list.alarm[0] = 1;
        }
        list.selection_pos = new_sel_pos;
        list.first_item = new_first_item;
        list.highlighted_item = new_high_item;
    }
    
    cur_item = new_cur_item;
    sel_pos = new_sel_pos;
    first_item = new_first_item;
    highlighted_item = new_high_item;
}

