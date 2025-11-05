//self.x = other.x + other.facing * 16;
//self.y = other.y;

if (other.aim_dist == 0) {
    if (other.facing == 1) {
        self.direction = 30;
    }
    else {
        self.direction = 150;
    }
}
else {
    if (instance_exists(self.my_guy.charge_ball)) {
        self.direction = point_direction(0, 0, self.my_guy.charge_ball.rel_x, self.my_guy.charge_ball.rel_y);
    }
    else {
        var hor_coef = lengthdir_x(sign(self.my_guy.desired_aim_dist), self.my_guy.desired_aim_dir);
        var ver_coef = lengthdir_y(sign(self.my_guy.desired_aim_dist), self.my_guy.desired_aim_dir);

        self.hspeed = hor_coef;
        self.vspeed = ver_coef;

        /*
        hspeed = 0;
        if(other.hor_dir_held)
            hspeed = other.facing;
        if(!other.looking_down)
            vspeed = -1;
        else 
            vspeed = 1;
        */
    }
}

self.speed = self.throw_speed;
self.hspeed += other.hspeed;
self.vspeed += other.vspeed;

self.placed = true;
self.sticky = true;

increase_stat(self.my_player, "grenades_thrown", 1, false);
