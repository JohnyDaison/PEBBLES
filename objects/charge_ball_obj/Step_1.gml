/// @description  BAR TINTS
if (!self.tint_updated) {
    self.base_bar_color = DB.colormap[? self.my_color];
}

event_inherited();

/// GLOW TINT
self.glow_tint = merge_color(self.tint, c_white, 0.5);
part_type_color1(self.pt, self.glow_tint);
