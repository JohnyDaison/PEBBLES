event_inherited();

var zone = self;
var detectCount = ds_list_size(self.detect_list);

for (var i = detectCount - 1; i >= 0; i--) {
    var obj = self.detect_list[| i];

    with (obj) {
        var inst = self;

        with (zone) {
            if (ds_list_find_index(zone.inside_list, inst.id) == -1 && place_meeting(zone.x, zone.y, inst.id)) {
                var log_str = "ENERGY BALL ZONE " + zone.zone_id + " ";

                if (trigger_script == trigger_target_script) {
                    log_str += "trigger_target fired by" + string(inst.id);
                    script_execute(trigger_script, inst.id);
                }
                else {
                    log_str += "trigger fired by" + string(inst.id);
                    trigger(zone.id, inst.id);
                }

                var params = create_params_map();
                params[? "who"] = inst.id;

                broadcast_event("ballzone_enter", zone.id, params);

                //my_console_log(log_str);

                ds_list_add(zone.inside_list, inst.id);
            }
        }
    }

}

var insideCount = ds_list_size(zone.inside_list);

for (var i = insideCount - 1; i >= 0; i--) {
    var inst = zone.inside_list[| i];

    if (!place_meeting(zone.x, zone.y, inst)) {
        ds_list_delete(zone.inside_list, i);
    }
}
