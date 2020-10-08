function gui_list_picker_script() {
	scroll_list = gui_parent.scroll_list;

	if(button_function == "up")
	{
	    if(scroll_list.cur_item > 0)
	    {
	        scroll_list.cur_item -= 1;
	        scroll_list.selection_pos -= 1;
	    }
    
	}
	if(button_function == "down")
	{
	    if(scroll_list.cur_item < scroll_list.item_count-1)
	    {
	        scroll_list.cur_item += 1;
	        scroll_list.selection_pos += 1;
	    }
	}

	gui_list_picker_update_script(gui_parent);


}
