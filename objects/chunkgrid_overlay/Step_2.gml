event_inherited();

self.heading = "00 ";

for (var xx = 0; xx < self.grid_width; xx += 1) {
    self.heading += my_string_format(xx mod 100, 2, 0) + " ";
}

for (var yy = 0; yy < self.grid_height; yy += 1) {
    self.ter_text[yy] = my_string_format(yy mod 100, 2, 0) + " ";
    
    for (var xx = 0; xx < self.grid_width; xx += 1) {
        var chunk = self.my_chunkgrid.grid[# xx, yy];
        var stateStr = chunk.active ? "a" : "h";
        
        self.ter_text[yy] += string(chunk.observerCount) + stateStr + " ";
    }
}
