/// @description  CREATE FIELD

//my_console_write("projector alarm " + string(id) + " " + string(singleton_obj.step_count));

if (!self.enabled) {
    exit;
}

if (!instance_exists(self.my_field)) {
    if (instance_exists(self.paired_projector)) {
        var new_col = self.my_color & self.paired_projector.my_color;

        if (new_col > g_dark && new_col < g_octarine) {
            var meanX = mean(self.x, self.paired_projector.x);
            var meanY = mean(self.y, self.paired_projector.y);

            self.my_field = instance_create(meanX, meanY, filter_field_obj);
            self.paired_projector.my_field = self.my_field;

            self.my_field.my_projectors[? 1] = self.id;
            self.my_field.my_projectors[? 2] = self.paired_projector.id;

            self.active = true;
        }
        else {
            self.active = false;
        }
    }
    else {
        self.enabled = false;
    }
}

if (!instance_exists(self.my_field)) {
    self.alarm[2] = 1;
}
