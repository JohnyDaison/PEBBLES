my_draw_set_font(label_font);
var dmg_str = "";

if (self.type == "paint_tool") {
    dmg_str = "";
    self.fade_ratio = 1;
    
    if (instance_exists(self.source)) {
        dmg_str += string(round(100 * self.source.energy)) + "| ";
    }

    if (self.damage < 0) {
        dmg_str += "-";
    }
    else {
        dmg_str += "+";
    }

    dmg_str += string(round(100 * abs(self.damage)));
}
else if (self.type == "energy_recharge") {
    if (self.damage < 0) {
        dmg_str = "-";
    }
    else {
        dmg_str = "+";
    }

    dmg_str += string(round(100 * abs(self.damage)));
}
else {
    if (self.damage < 0) {
        dmg_str = "+"; // negative damage heals
    }

    dmg_str += string(round(100 * abs(self.damage)));
}


var half_width = string_width(dmg_str) / 2 + 4;
var half_height = string_height(dmg_str) / 2 + 2;

draw_set_color(self.bg_color);
draw_set_alpha(self.bg_alpha * self.fade_ratio);
draw_roundrect(self.x - half_width, self.y - half_height, self.x + half_width, self.y + half_height, false);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_alpha(self.fade_ratio);
draw_set_color(makeTextOutlineColor(self.tint, true));

my_draw_text(self.x - 1, self.y - 1, dmg_str);
my_draw_text(self.x + 1, self.y + 1, dmg_str);

draw_set_color(self.tint);
my_draw_text(self.x, self.y, dmg_str);

draw_set_halign(fa_left);
draw_set_valign(fa_top);

event_inherited();
