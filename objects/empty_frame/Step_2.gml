/// @description  MOVE MY ELEMENTS WITH ME

var xdiff = self.x - self.xprevious;
var ydiff = self.y - self.yprevious;
var frame = self.id;

if (xdiff != 0 || ydiff != 0) {
    with (gui_element) {
        if (self.parent_frame == frame && self.rel_position == "relative") {
            self.x = self.parent_frame.x + self.rel_x;
            self.y = self.parent_frame.y + self.rel_y;
        }
    }
}
