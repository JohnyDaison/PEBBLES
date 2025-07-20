/// @description  BAR TINTS
if (!tint_updated) {
    base_bar_color = DB.colormap[? my_color];
}

event_inherited();

/// GLOW TINT
self.glow_tint = merge_color(self.tint,c_white,0.5);
part_type_color1(pt,self.glow_tint);
