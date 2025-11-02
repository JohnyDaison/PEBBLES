// OPEN LITTLE config_window WITH INT DIAL AND OK BUTTON
if (!instance_exists(self.config_window)) {
    self.config_window = add_frame(jump_pad_config_window);
    self.config_window.x = cursor_obj.x;
    self.config_window.y = cursor_obj.y;
    self.config_window.my_pad = self.id;
}
