/// @description  MOVE MY ELEMENTS WITH ME

var xdiff = x - xprevious;
var ydiff = y - yprevious;
if(xdiff != 0 || ydiff != 0)
{
    with(gui_element)
    {
        if(parent_frame == other.id && rel_position == "relative")
        {
            x = parent_frame.x + rel_x;
            y = parent_frame.y + rel_y;
        }
    }
}

