event_inherited();

self.damage = 0;
self.bg_alpha = 0.4;
self.alarm[1] = 2;
self.type = "";

self.max_number = 50;

if (instance_number(self.object_index) > self.max_number) {
    // destroys the oldest damage popup
    instance_destroy(self.object_index.id)
}
