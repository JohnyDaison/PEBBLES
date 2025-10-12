/// @description  FOLLOW GUY
if (instance_exists(self.my_guy)) {
    self.x = self.my_guy.x;
    self.y = self.my_guy.y;
    self.invisible = self.my_guy.invisible;
    self.visible = !self.invisible;

    if (part_system_exists(self.system)) {
        part_system_automatic_draw(self.system, !self.invisible);
    }
}
