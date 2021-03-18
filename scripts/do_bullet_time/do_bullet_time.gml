function do_bullet_time(seconds) {
    singleton_obj.bullet_time_end_time = round(current_time + seconds * 1000);
}