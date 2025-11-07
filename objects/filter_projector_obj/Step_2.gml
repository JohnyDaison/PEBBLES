/// @description COLOR AND POSITION UPDATE

// COLOR
if (instance_exists(self.my_block)) {
    var new_col = self.my_block.my_color;

    if (new_col != self.my_color) {
        self.my_color = new_col;
        self.tint_updated = false;
    }
}

// POSITION CHANGED
if (self.xprevious != self.x || self.yprevious != self.y) {
    // UPDATE FIELD
    if (instance_exists(self.my_field)) {
        self.my_field.ready = false;
    }

    // UPDATE DIRECTION OF PROJECTORS
    if (instance_exists(self.paired_projector)) {
        var proj = self.id;
        var other_proj = self.paired_projector;

        // TODO: could angle_difference be used here?
        repeat(2) {
            var dir = point_direction(other_proj.x, other_proj.y, proj.x, proj.y);
            var tempdir = (round(dir / 90) * 90) mod 360;
            var reldir = dir;

            if (tempdir == 0 && dir > 180) {
                reldir = dir - 360;
            }

            if (abs(tempdir - reldir) < 1) {
                proj.image_angle = tempdir;
            }
            else {
                proj.image_angle = round((dir + 45) / 90) * 90 - 45;
            }

            proj = self.paired_projector;
            other_proj = self.id;
        }
    }
}

event_inherited();
