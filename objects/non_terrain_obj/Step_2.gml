/// @description HANDLE LEAVING CHUNK
// This should be inherited at the end of a script, not the start

if (instance_exists(chunkgrid_obj)) {
    var cur_grid_x = floor(self.x / chunkgrid_obj.chunk_size);
    var cur_grid_y = floor(self.y / chunkgrid_obj.chunk_size);

    // GRID POSITION UPDATE
    if (cur_grid_x != self.chunkgrid_x || cur_grid_y != self.chunkgrid_y) {
        chunk_deregister(chunkgrid_obj.id, self.id);
        //chunk_register(chunkgrid_obj.id, self.id); This doesn't work in the same step because of instance_change.
        self.alarm[7] = 1;
    }
}
