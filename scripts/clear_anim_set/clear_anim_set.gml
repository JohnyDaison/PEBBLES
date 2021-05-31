function clear_anim_set(clear_displays) {
    var i, map, display;
    for(i=self.steps_total-1; i>=0; i--)
    {
        map = self.steps[| i];
        ds_map_destroy(map);
    }
    ds_list_clear(self.steps);

    if(clear_displays)
    {
        var count = ds_list_size(self.members);
        for(i=count-1; i>=0; i--)
        {
            display = self.members[| i];
            clear_display(display);
        }
    }

    self.duration_total = 0;
    self.steps_total = 0;
    ds_map_clear(self.visible_steps_total);
}
