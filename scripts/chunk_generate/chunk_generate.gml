/// @param {Real} chunk_x
/// @param {Real} chunk_y
/// @param {Real} seed
function chunk_generate(chunk_x, chunk_y, seed) {
    if (!instance_exists(chunkgrid_obj)) {
        return false;
    }

    var grid_obj = chunkgrid_obj.id;

    with (grid_obj) {
        var chunk = self.grid[# chunk_x, chunk_y];

        var left_x = self.chunk_size * chunk_x;
        var right_x = self.chunk_size * (chunk_x + 1);
        var top_y = self.chunk_size * chunk_y;
        var bottom_y = self.chunk_size * (chunk_y + 1);

        if (left_x < singleton_obj.grid_margin || right_x > (room_width - singleton_obj.grid_margin) ||
            top_y < singleton_obj.grid_margin || bottom_y > (room_height - singleton_obj.grid_margin)) {
            return false;
        }

        random_set_seed(seed);

        for (var xx = left_x; xx < right_x; xx += 32) {
            for (var yy = top_y; yy < bottom_y; yy += 32) {
                if (random(15) < 1) {
                    if (collision_point(xx, yy, terrain_obj, false, false) == noone) {
                        instance_create(xx, yy, wall_obj);
                    }
                }
                if (random(40) < 1) {
                    if (collision_point(xx, yy, terrain_obj, false, false) == noone) {
                        instance_create(xx, yy, platform_obj);
                    }
                }
            }
        }

        chunk[? "generated"] = true;
    }

    return true;
}
