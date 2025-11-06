part_emitter_destroy(self.system, self.em);
part_type_destroy(self.pt);
part_system_destroy(self.system);

// VIEWSHAKE

if (self.object_index == big_projectile_obj && self.impact_strength > 0) {
    with (guy_obj) {
        var cam = self.my_player.my_camera;

        if (cam != noone && self.my_player.my_guy == self.id) {
            var dist = point_distance(self.x, self.y, other.x, other.y);

            if (dist < other.shake_range) {
                viewshake(cam, other.direction,
                    min(20, 7 * max(1, other.impact_strength) * sqrt(1 - dist / other.shake_range)));
            }
        }
    }
}

event_inherited();
