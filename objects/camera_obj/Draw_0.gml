/// @description  BEFORE VIEW
if(view > -1 && view_enabled)
{
    if(on && view_get_visible(view) && view > 1 && view_current == view-1)
    {
        camera_before_view();
    }
}
