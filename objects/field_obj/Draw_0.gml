event_inherited();

draw_set_alpha(self.field_alpha);

// TODO: tinted texture drawing
// TODO: why is rectangle not using blendmode?

switch (self.shape) {
    case shape_circle:

        gpu_set_blendmode_ext(bm_dest_colour, bm_one);
        draw_circle_colour(self.x, self.y, self.radius, self.tint, c_white, false);
        gpu_set_blendmode(bm_normal);

        break;

    case shape_rect:

        draw_set_color(self.tint);
        draw_roundrect(round(self.x - self.width / 2), round(self.y - self.height / 2), round(self.x + self.width / 2), round(self.y + self.height / 2), false)

        break;
}

draw_set_alpha(1);
