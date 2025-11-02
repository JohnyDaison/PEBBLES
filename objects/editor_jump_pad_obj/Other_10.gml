var last_color = self.color;
self.color = ceil(g_white * (self.max_power / DB.max_jump_pad_power));
if (last_color != self.color) {
    self.tint = DB.colormap[? self.color];
    self.final_tint = self.tint;
}
self.ready = (self.color > g_red);
