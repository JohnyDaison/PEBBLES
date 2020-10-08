event_inherited();

self.font = label_font;
self.draw_border = false;
self.draw_thick_border = false;
self.thick_border_size = 2;
self.draw_bg_color = true;
self.bg_color = merge_colour(c_gray,c_black,0.7);
self.bg_alpha = 0.5;
self.border_color = c_ltgray;
self.width = 160;
self.height = 32;
self.locked = false;

align = "center";
text_align = "center";
show_prompt = false;
centered = false; 
// this variable doesn't mean it SHOULD be centered, but rather that it HAS BEEN centered,
// in other words, setting it to true will prevent the centering code from running

multiline = false;
line_separation = 20;
