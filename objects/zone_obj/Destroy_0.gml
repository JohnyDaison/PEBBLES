ds_list_destroy(self.triggerables);
ds_list_destroy(self.trigger_targets);
ds_list_destroy(self.detect_list);
ds_list_destroy(self.inside_list);

event_inherited();
