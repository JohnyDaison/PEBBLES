/// @description  DARK FIELD TRAIL
var field = instance_create(self.x, self.y, black_force_field_obj);
field.field_power = 0.2;
field.radius = self.radius * min(1, self.force_used / self.force);
field.temporary = true;
field.holographic = self.holographic;
field.my_player = self.my_player;
field.my_guy = self.my_guy;

self.alarm[2] = self.trail_delay;
