/// @param {Id.Instance} from origin
/// @param {Asset.GMObject} object
/// @param {Real} range
/// @param {String} condition
/// @param {String} param
/// @return {Id.DsList<Id.DsMap<Any>>} list of maps with keys "id" and "distance"
function find_nearest_instances(from, object, range = 1024, condition = "", param = "") {
    var visible_type = "move";

    if (condition == "visible") {
        visible_type = param;
    }

    var results = ds_list_create();
    register_ds("results", "ds_list_of_map", results, id);


    with (from) {
        with (object) {
            var instance = id;
            with (other) {
                var dist = point_distance(x, y, instance.x, instance.y);

                // npc_line_of_sight might not be the best script for this purpose
                if ((dist <= range || range == -1)
                    && (condition != "visible" || npc_line_of_sight_instance(instance, visible_type))
                    && (condition != "holographic" || instance.holographic == param)
                    && (condition != "player" || instance.my_player == param)
                    && (condition != "with_label_not_mine" || (instance.my_guy != id && instance.draw_label == param))
                ) {
                    var new_result = ds_map_create();
                    new_result[? "id"] = instance;
                    new_result[? "distance"] = dist;

                    var count = ds_list_size(results);
                    var position = count;

                    for (var i = 0; i < count; i++) {
                        var result = results[| i];
                        if (result[? "distance"] > dist) {
                            position = i;
                            break;
                        }
                    }

                    ds_list_insert(results, position, new_result);
                }
            }
        }
    }

    return results;
}
