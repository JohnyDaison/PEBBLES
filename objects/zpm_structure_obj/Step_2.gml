if (!instance_exists(self.my_block)) {
    self.my_block = instance_nearest(x - 16, y - 16, wall_obj);
    
    if (!place_meeting(x, y, self.my_block)) {
        instance_destroy();
    }
    else {
        x = self.my_block.x + 15;
        y = self.my_block.y + 15;
    }
}

// PRESERVE COLOR
if (self.my_block.my_color > g_dark) {
    self.last_block_color = self.my_block.my_color;
    
    if (self.my_block.my_next_color == g_dark) {
        self.my_block.my_next_color = self.my_block.my_color;
    }
}
else if (self.last_block_color > g_dark) {
    self.my_block.my_color = self.last_block_color;
    self.my_block.my_next_color = self.last_block_color;
    self.my_block.tint_updated = false;
}

// GIVE ENERGY TO BLOCK
self.my_block.energy += self.energy_tick;

event_inherited();
