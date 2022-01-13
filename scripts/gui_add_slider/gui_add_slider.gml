function gui_add_slider(xx, yy, default_value, min_value, max_value) {
    var slider;

    slider = gui_child_init(xx+self.eloffset_x,yy+self.eloffset_y, gui_slider);
    slider.value = default_value;
    slider.min_value = min_value;
    slider.max_value = max_value;
    slider.bar_min_value = min_value;
    slider.bar_max_value = max_value;

    return slider;
}
