/// @description  BEFORE VIEW
if(view > -1 && view_enabled)
{
    if(on && __view_get( e__VW.Visible, view ) && view > 1 && view_current == view-1)
    {
        camera_before_view();
    }
}

