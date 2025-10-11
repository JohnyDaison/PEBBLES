self.image_index = irandom(10);
self.alarm[0] = irandom(90 - round(90 * (self.damage / self.hp))) + 1;
