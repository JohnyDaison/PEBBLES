if (self.my_color > g_dark && self.energy > 0) {
    if (!instance_exists(self.flame)) {
        self.flame = instance_create_depth(self.x, self.y, 16, ball_torch_flame_obj);
        self.flame.my_guy = self.id;
    }
} else {
    if (instance_exists(self.flame)) {
        self.flame.active = false;
        self.flame.alarm[0] = 1;
    }
}

self.energy = clamp(self.energy, 0, self.max_energy);

var energy_ratio = self.energy / self.max_energy;

self.ambient_light = energy_ratio * self.max_ambient_light;
self.direct_light = energy_ratio * self.max_direct_light;
