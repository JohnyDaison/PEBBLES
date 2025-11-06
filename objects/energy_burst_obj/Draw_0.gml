draw_sprite_ext(self.sprite_index, self.image_index, self.x, self.y, 1, 1, self.image_angle, self.tint, self.image_alpha * self.holo_alpha);

// light
var maxLightAlpha = self.image_alpha * 0.2 * self.holo_alpha;
draw_primitive_begin(pr_trianglestrip);

draw_vertex_colour(self.x1, self.y1, self.tint, maxLightAlpha);
draw_vertex_colour(self.x2, self.y2, self.tint, maxLightAlpha);
draw_vertex_colour(self.x3, self.y3, self.tint, 0);
draw_vertex_colour(self.x4, self.y4, self.tint, 0);

draw_primitive_end();

event_inherited();
