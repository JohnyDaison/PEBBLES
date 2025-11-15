/// @description DETECT TRIGGERABLES
var count = ds_list_size(self.triggerables);
var triggerables = self.triggerables;
var zone = self;

for (var i = 0; i < count; i++) {
    with (triggerables[| i]) {
        var inst = self;

        if (place_meeting(inst.x, inst.y, zone.id)) {
            ds_list_add(zone.trigger_targets, inst.id);
            zone.trigger_script = trigger_target_script;
        }
    }
}
