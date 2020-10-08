//tooltip = string(instance_number(wallclimb_item_obj));

view_drag = false;
if(instance_exists(editor_camera))
{
    if(editor_camera.dragging)
    {
        view_drag = true;
    }
}


if(singleton_obj.fullscreen_set)
{
    x = display_mouse_get_x()/display_get_width()*display_get_gui_width();
    y = display_mouse_get_y()/display_get_height()*display_get_gui_height();
}
else
{
    x = window_mouse_get_x();
    y = window_mouse_get_y();
}

if(!view_drag)
{
    if(view_enabled)
    {
        var zoom = 1;
        
        if(instance_exists(main_camera_obj))
        {
            zoom = main_camera_obj.normal_zoom;
        }
        
        if(__view_get( e__VW.Visible, 0 ))
        {
            room_x = __view_get( e__VW.XView, 0 ) + x/zoom;
            room_y = __view_get( e__VW.YView, 0 ) + y/zoom;
        }
        else
        {
            view_found = false;
            view = 1;
            while(!view_found && __view_get( e__VW.Visible, view ))
            {                
                view_x = x - __view_get( e__VW.XPort, view );
                view_y = y - __view_get( e__VW.YPort, view );

                inside = false;
                if(view_x >= 0 && view_x < __view_get( e__VW.WPort, view ) && view_y >= 0 && view_y < __view_get( e__VW.WPort, view ))          
                {
                    var cam;
                    with(camera_obj)
                    {
                        if(view == other.view)
                            cam = id;
                    }
                    room_x = __view_get( e__VW.XView, view ) + view_x/cam.zoom_level;
                    room_y = __view_get( e__VW.YView, view ) + view_y/cam.zoom_level;
                    view_found = true;
                }
                else 
                {
                    view++;
                } 
            }
        }
    }
    else
    {
        room_x = mouse_x;
        room_y = mouse_y;
    }
}

// CHECK MOUSE
if(!DB.mouse_has_moved)
{
    if(x != last_x || y != last_y)
    {
        DB.mouse_has_moved = true;
    }
}
last_x = x;
last_y = y;

if(room == level_editor)
{
    if(DB.mouse_has_moved && keyboard_check_pressed(vk_control))
    {
        old_tool = active_tool.object_index;
        tool_activate(ctrl_tool);   
    }
    
    if(DB.mouse_has_moved && keyboard_check_released(vk_control))
    {
        tool_deactivate(ctrl_tool);
        tool_activate(old_tool);   
    }
}
if(DB.mouse_has_moved && mouse_check_button_pressed(mb_any))
{
    singleton_obj.last_gui_device = mouse;
    var focused_frame = frame_manager.focused_child;
    var focus_found = false;
    show_debug_message("focused frame: " + string(focused_frame));
    
    if(instance_exists(focused_frame))
    {
        show_debug_message("focused object_index: " + object_get_name(focused_frame.object_index));
        
        if(object_is_ancestor(focused_frame.object_index, empty_frame))
        {
            if(focused_frame.modal)
            {
                focus_found = true;
            }
            else
            {
                if(object_is_ancestor(focused_frame.object_index, gui_object))
                {
                    with(focused_frame)
                    {
                        if(visible && !focus_found && x <= cursor_obj.x && cursor_obj.x < x+width && y <= cursor_obj.y && cursor_obj.y < y+height)
                        {
                            show_debug_message("cursor is in frame " + string(id));
                            if(focused)
                            {
                                show_debug_message("manager focused on me and I am");
                                focus_found = true;
                            }
                            else
                            {
                                show_debug_message("manager focused on me and I'm not");
                                gui_get_focus();
                                focus_found = true;
                            }
                        }
                    }
                }
            }
        }
    }
    
    if(!focus_found)
    {
        show_debug_message("focused frame not found, clearing all");
        gui_clear_focus(frame_manager);
    } 
    else if(instance_exists(cursor_obj.focus) && !cursor_obj.focus.visible)
    {
        show_debug_message("focused element invisible, clearing all");
        gui_clear_focus(frame_manager);   
    }
    
    with(empty_frame)
    {
        if(visible && !focus_found && x <= cursor_obj.x && cursor_obj.x < x+width && y <= cursor_obj.y && cursor_obj.y < y+height)
        {
            show_debug_message("cursor is in frame " + string(id));
            gui_get_focus();
            cursor_obj.focus_found = true;    
        }
    }
    if(focus_found)
    {
        show_debug_message("focus found, clearing tools");
        clear_tools();
    }
    else
    {
        if(instance_exists(last_active_tool))
        {
            tool_activate(last_active_tool);
        }
    }
}
else
{
    if(singleton_obj.last_gui_device == mouse)
    {
        singleton_obj.last_gui_device = -1;    
    }
}

if(!instance_exists(active_tool))
{
    glow_ratio += glow_dir*glow_step;
    if(glow_ratio >= 1-glow_step)
    {
        glow_ratio = 1-glow_step;
        glow_dir = -1;
    }
    if(glow_ratio <= glow_min)
    {
        glow_ratio = glow_min;
        glow_dir = 1;
        if(!instance_exists(gamemode_obj))
        {
            my_color = irandom(7);
            tint_updated = false;
        }
    }
}
else
{
    glow_ratio = 0.5;
    my_color = g_white;
    last_active_tool = active_tool.object_index;
}

if(self.tint_updated == false)
{
    self.new_tint = ds_map_find_value(DB.colormap,my_color);

    self.tint = merge_color(self.tint,self.new_tint,1/6);

    if(self.tint == self.new_tint)
    {
        self.tint_updated = true;
    }
}

focus = noone;
focus_depth = 20000;
if(DB.mouse_has_moved)
{
    with(gui_element)
    {
        if(want_focus && visible)
        {
            if(cursor_obj.x>x && cursor_obj.x<(x+self.width)
            && cursor_obj.y>y && cursor_obj.y<(y+self.height)
            && (cursor_obj.focus == noone || depth < cursor_obj.focus_depth))
            {
                cursor_obj.focus = id;
                cursor_obj.focus_depth = depth;
            }
        }
    }
}
