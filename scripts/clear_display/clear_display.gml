function clear_display(display) {
    if(instance_exists(display))
    {
        empty_display(display);
        display.ready = false;
        display.active = false;
        display.reset = true;
    }
}
