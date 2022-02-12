/// @description gui_child_init(x,y,object_index);
/// @function gui_child_init
/// @param x
/// @param y
/// @param object_index
function gui_child_init() {
    var xx,yy,object;

    xx = argument[0];
    yy = argument[1];
    object = argument[2];

    var child = instance_create(xx,yy,object);

    child.gui_parent = self.id;

    if(object_is_ancestor(self.object_index, empty_frame))
    {
        child.parent_frame = self.id;
    }
    else
    {
        child.parent_frame = self.parent_frame;
    }

    var parent = child.parent_frame;

    child.rel_x = xx - parent.x;
    child.rel_y = yy - parent.y;
    child.depth = self.depth-1;
    child.visible = self.visible;

    ds_list_add(self.gui_content,child);

    return child;
}
