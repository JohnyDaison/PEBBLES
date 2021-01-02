function find_display_instance(display_type, display_index, display_id) {
    var disp_obj = noone;

    if(display_type == "index")
    {
        disp_obj = self.order[? display_index];
    }
    else if(display_type == "id")
    {
        disp_obj = self.member_ids[? display_id];
    }

    return disp_obj;
}
