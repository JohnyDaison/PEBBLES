function control_dir_to_vector(dir_string, distance) {
    var vector = {x: 0, y: 0};
    
    switch(dir_string)
    {
        case "left":
            vector.x = -distance;
            vector.y = 0;
            break;
        case "right":
            vector.x = distance;
            vector.y = 0;
            break;
        case "up":
            vector.x = 0;
            vector.y = -distance;
            break;
        case "down":
            vector.x = 0;
            vector.y = distance;
            break;
    }
    
    return vector;
}