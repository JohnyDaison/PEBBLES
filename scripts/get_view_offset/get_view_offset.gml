function get_view_offset(view) {
    var offset_set = false;
    var x_offset, y_offset;
    
    if(view_get_visible(view))
    {
        x_offset = view_get_xport(view);
        y_offset = view_get_yport(view);
        offset_set = true;
    }
    else if(view_get_visible(main_camera_obj.view))
    {
        x_offset = view_get_xport(main_camera_obj.view) + (view_get_wport(main_camera_obj.view) / 2) * (view-1);
        y_offset = view_get_yport(main_camera_obj.view);
        offset_set = true;
    }
    
    if(!offset_set)
    {
        x_offset = view_get_xport(0) + (view_get_wport(0) / 2) * (view-1);
        y_offset = view_get_yport(0);
    }
    
    return new MyVec2(x_offset, y_offset);
}