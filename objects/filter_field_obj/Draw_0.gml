if (self.ready) {
    /*
    draw_set_alpha(0.8);
    
    var filter = make_colour_rgb(sign(self.my_color & g_red)*255, sign(self.my_color & g_green)*255, sign(self.my_color & g_blue)*255);
    gpu_set_blendmode_ext(bm_dest_color, bm_src_alpha_sat);
    draw_roundrect_colour_ext(self.x1, self.y1, self.x2, self.y2,
                                self.corner_radius, self.corner_radius, filter, filter, false);
    */

    //gpu_set_blendmode(bm_normal);

    draw_set_alpha(self.alpha / 2);
    draw_roundrect_colour_ext(self.x1, self.y1, self.x2, self.y2,
                                self.corner_radius, self.corner_radius, self.tint, self.tint, false);

    draw_set_alpha(self.alpha / 4);
    draw_roundrect_colour_ext(self.x1 + self.border_size, self.y1 + self.border_size,
                                self.x2 - self.border_size, self.y2 - self.border_size,
                                self.corner_radius, self.corner_radius, self.tint, self.tint, true);
}

event_inherited();
