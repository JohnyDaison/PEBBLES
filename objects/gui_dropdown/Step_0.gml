if(instance_exists(list_picker) && instance_exists(list_picker.scroll_list))
{
    if(!inited) 
    {
        if(self.value != -1)
        {
            list_picker.select_item_by_index(self.value);
        }
        inited = true;
    }
    else
    {
        self.value = list_picker.cur_item;
        self.value_id = list_picker.cur_item_id;
    }
    
    var item = list_picker.scroll_list.items[| self.value];
    if(is_undefined(item))
    {
        //show_debug_message(type + " DROPDOWN(" + string(id) + ") has INVALID value");
        self.button.text = "";
        self.button.icon = noone;
        self.button.enabled = false;
    }
    else
    {
        self.button.enabled = self.enabled && ds_list_size(list_picker.scroll_list.items) > 1;
        if(type == "text")
        {
            self.button.text = item;
            self.button.icon = dropdown_arrow_spr;
            self.button.center_icon = false;
        }
        else if(type == "flag")
        {
            self.button.text = "";
            self.button.icon = item;
            self.button.center_icon = true;
        }
    }
}

