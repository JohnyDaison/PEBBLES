/// @param {Bool} _facing_right
function set_guy_facing(_facing_right) {
    self.facing_right = !!_facing_right;
    
    if (!self.frozen_in_time && self.status_left[? "frozen"] == 0) {
        if (self.facing_right) {
            self.facing = 1;
        }
        else {
            self.facing = -1;
        }
    }
}
