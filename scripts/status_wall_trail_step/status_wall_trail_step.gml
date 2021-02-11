function status_wall_trail_step() {
    var no_double_jump = doublejump_count == max_doublejumps || locked;
    var create_walls = !airborne || (vspeed >= 0 && no_double_jump);
    
    if(create_walls) {
        var grid_x = round((x + hspeed) / 32);
        var grid_y = ceil((bbox_bottom + 1 + vspeed) / 32);
        
        var left_x = (grid_x - 1) * 32;
        var right_x = grid_x * 32;
        var below_y = grid_y * 32;
        var wall;
        
        if(below_y >= 0 && below_y < room_height) {
            if(left_x >= 0 && left_x < room_width) {
                if(!position_meeting(left_x, below_y, terrain_obj)) {
                    wall = instance_create(left_x, below_y, wall_obj);
                    wall.my_next_color = my_color;
                    wall.energy = wall.status_threshold;
                }
            }
            if(right_x >= 0 && right_x < room_width) {
                if(!position_meeting(right_x, below_y, terrain_obj)) {
                    wall = instance_create(right_x, below_y, wall_obj);
                    wall.my_next_color = my_color;
                    wall.energy = wall.status_threshold;
                }
            }
        }
    }
}