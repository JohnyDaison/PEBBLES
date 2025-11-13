/// @param {Real} toX
/// @param {Real} toY
/// @param {Bool} unique
/// @return {Id.Instance}
function get_closest_spawner(toX, toY, unique) {
    var closest_spawner = instance_nearest(toX, toY, guy_spawner_obj);

    if (!instance_exists(closest_spawner)) {
        return noone;
    }

    if (!unique) {
        return closest_spawner;
    }

    var closest_dist = point_distance(closest_spawner.x, closest_spawner.y, toX, toY);

    with (guy_spawner_obj) {
        var dist = point_distance(self.x, self.y, toX, toY);

        if (closest_spawner.id != self.id && abs(dist - closest_dist) < 8) {
            return noone;
        }
    }

    return closest_spawner;
}
