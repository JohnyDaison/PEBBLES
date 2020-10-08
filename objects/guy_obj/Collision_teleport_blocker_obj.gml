guy = self;

if (guy.has_tped) {
    guy.x = guy.pre_tp_x;
    guy.y = guy.pre_tp_y;
    guy.last_x = guy.x;
    guy.last_y = guy.y;
    guy.has_tped = false;
}