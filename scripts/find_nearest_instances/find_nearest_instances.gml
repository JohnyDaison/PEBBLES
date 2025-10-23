/// @param {Id.Instance} from origin
/// @param {Asset.GMObject} object
/// @param {Real} range default = 1024
/// @param {String} condition optional, one of: "visible", "holographic", "player", "with_label_not_mine"
/// @param {String} param optional, specific to given condition
/// @return {Array<Struct.GameQueryResult>} list of maps with keys "id" and "distance"
function find_nearest_instances(from, object, range = 1024, condition = "", param = "") {
    var visible_type = "move";

    if (condition == "visible") {
        visible_type = param;
    }

    var results = [];

    with (object) {
        var instance = id;
        
        with (from) {
            var dist = point_distance(from.x, from.y, instance.x, instance.y);

            // TODO: npc_line_of_sight might not be the best script for this purpose
            if ((dist <= range || range == -1)
                && (condition != "visible" || npc_line_of_sight_instance(instance, visible_type))
                && (condition != "holographic" || instance.holographic == param)
                && (condition != "player" || instance.my_player == param)
                && (condition != "with_label_not_mine" || (instance.my_guy != id && instance.draw_label == param))
            ) {
                var new_result = new GameQueryResult();
                
                new_result.x = instance.x;
                new_result.y = instance.y;
                new_result.id = instance.id;
                new_result.distance = dist;

                var count = array_length(results);
                var position = count;

                for (var i = 0; i < count; i++) {
                    var result = results[i];

                    if (result.distance > dist) {
                        position = i;
                        break;
                    }
                }

                array_insert(results, position, new_result);
            }
        }
    }

    return results;
}
