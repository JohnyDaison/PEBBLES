self.visible = (DB.console_mode == CONSOLE_MODE.DEBUG);

if (!self.in_group && self.zone_id != "") {
    group_auto_group(self.group_id, self.id, self.zone_id);

    self.in_group = true;
}
