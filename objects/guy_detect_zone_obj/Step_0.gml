event_inherited();

var detectCount = ds_list_size(self.detect_list);
var zone = self;

for (var i = detectCount - 1; i >= 0; i--) {
    var obj = self.detect_list[| i];

    with (obj) {
        var inst = self;

        with (zone) {
            if (ds_list_find_index(zone.inside_list, inst.id) == -1 && place_meeting(zone.x, zone.y, inst.id)) {
                var log_str = "GUY ZONE " + zone.zone_id + " ";

                if (zone.trigger_script == trigger_target_script) {
                    log_str += "trigger_target fired by" + string(inst.id);
                    script_execute(zone.trigger_script, inst.id);
                }
                else {
                    log_str += "trigger fired by" + string(inst.id);
                    trigger(zone.id, inst.id);
                }

                var params = create_params_map();
                params[? "who"] = inst.id;

                broadcast_event("zone_enter", zone.id, params);

                //my_console_log(log_str);

                ds_list_add(zone.inside_list, inst.id);
            }
        }
    }

}

var insideCount = ds_list_size(inside_list);

for (var i = insideCount - 1; i >= 0; i--) {
    var inst = self.inside_list[| i];

    if (!place_meeting(self.x, self.y, inst)) {
        ds_list_delete(self.inside_list, i);
    }
}
