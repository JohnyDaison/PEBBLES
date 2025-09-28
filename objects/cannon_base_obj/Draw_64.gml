if (gamemode_obj.limit_reached) {
    exit;
}

draw_set_alpha(1);

// BASE
draw_set_color(c_white);
draw_sprite(self.sprite_index, 0, self.gui_x, self.gui_y);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// GLOW
draw_sprite_ext(self.sprite_index, 1, self.gui_x, self.gui_y, 1, 1, 0, DB.colormap[? shot_color], 1);

// ARROW
if (instance_exists(self.charge_ball)) {
    var dir = point_direction(self.x, self.y, self.charge_ball.x, self.charge_ball.y);
    draw_sprite_ext(curved_arrow_spr, 0,
        self.gui_x + lengthdir_x(self.arrow_dist, dir),
        self.gui_y + lengthdir_y(self.arrow_dist, dir),
        2, 1, dir, c_white, 0.9);
}

// HP
if (self.damage < self.hp) {
    var hp_ratio = (self.hp - self.damage) / self.hp;
    var hpbar_xx = self.hpbar_x1 + hp_ratio * self.hpbar_width;

    // BG
    draw_set_colour(c_dkgray);
    draw_rectangle(self.gui_x + self.hpbar_x1, self.gui_y + self.hpbar_y1,
        self.gui_x + self.hpbar_x2, self.gui_y + self.hpbar_y2, false);

    // BAR
    draw_set_colour(self.hpbar_tint);
    draw_rectangle(self.gui_x + self.hpbar_x1, self.gui_y + self.hpbar_y1,
        self.gui_x + hpbar_xx, self.gui_y + self.hpbar_y2, false);

    // COVER
    draw_sprite(cannon_hpbar_cover_spr, 0, self.gui_x, self.gui_y);
}

// ORB NUMBERS
var number_y = self.gui_y + 64;
my_draw_set_font(label_font);

for (var i = 1; i <= 3; i++) {
    var number_x = self.gui_x + ((4 - i) - 0.5) * self.slot_size + self.slot_offset;
    if (i == 3)
        i = 4;

    var number_str = string(self.orbs[? i]);
    var orb_tint = merge_colour(DB.colormap[? i], c_white, self.orb_light[? i] * 0.9);

    draw_sprite_ext(color_orb_icon, 0, number_x, number_y, 1 + self.orb_light[? i], 1 + self.orb_light[? i], 0, orb_tint, 0.8);

    draw_set_color(c_black);
    my_draw_text(number_x + 2, number_y + 2, number_str);

    draw_set_color(c_white);
    my_draw_text(number_x, number_y, number_str);
}

// OUT OF AMMO
if (instance_exists(self.ammo_popup)) {
    my_draw_set_font(self.ammo_popup.font);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_alpha(1);

    var ammoX = self.gui_x + self.ammo_x;
    var ammoY = self.gui_y + self.ammo_y;
    var ammoStr = self.ammo_popup.str;

    // TODO: rewrite this line
    draw_set_color(self.ammo_popup.tint - c_gray);
    my_draw_text(ammoX - 1, ammoY - 1, ammoStr);
    my_draw_text(ammoX + 1, ammoY + 1, ammoStr);

    draw_set_color(self.ammo_popup.tint);
    my_draw_text(ammoX, ammoY, ammoStr);

    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}
