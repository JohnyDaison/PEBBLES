event_inherited();

if (self.temporary) {
    self.radius -= 1;
    if (self.radius <= 0) {
        instance_destroy();
        exit;
    }
}

self.width = 2 * self.radius;
self.height = 2 * self.radius;
self.field_focus = self.radius / 2;

var force_field = self;

switch (shape) {
    case shape_circle:

        // GUY
        with (guy_obj) {
            if (self.holographic == other.holographic && self.my_color != force_field.my_color) {
                with (force_field) {
                    var guy = collision_circle(self.x, self.y, self.radius, other.id, false, true);

                    if (instance_exists(guy)) {
                        if (!guy.stuck) {
                            apply_force(guy, self.repels);
                        }
                    }
                }
            }
        }

        // COLOR PROJECTILES
        with (projectile_obj) {
            if (self.holographic == other.holographic) {
                with (other) {
                    var proj = collision_circle(self.x, self.y, self.radius, other.id, false, true);

                    if (instance_exists(proj) && proj.my_color != g_dark) {
                        apply_force(proj, self.repels);
                    }
                }
            }
        }

        // ITEMS
        with (item_obj) {
            if (self.holographic == other.holographic && instance_exists(self.my_guy)) {
                if (!is_shielded(self.id) && !self.collected && (
                    (self.my_guy.id == self.id && self.collectable) || (self.placed && self.stuck_to == noone)
                )) {
                    with (other) {
                        var item = collision_circle(self.x, self.y, self.radius, other.id, false, true);

                        if (instance_exists(item) && item.my_color != g_dark) {
                            apply_force(item, self.repels);
                        }
                    }
                }
            }
        }

        // AOE
        /*
        with(aoe_obj)
        {
            if(holographic == other.holographic)
            {
                with(other)
                { 
                    aoe = collision_circle(x,y,radius,other.id,false,true);
                    if(instance_exists(aoe))
                    {
                        apply_force(aoe,repels);
                    }
                    aoe = noone;
                }
            }
        }
        */

        // DARK PROJECTILES
        /*
        with(black_projectile_obj)
        {
            if(holographic == other.holographic)
            {
                with(other)
                { 
                    if(point_distance(x,y,other.x,other.y) < (radius+other.radius))
                    {
                        apply_force(other,repels);
                    }
                }
            }
        }
        */

        // MOBS
        with (mob_obj) {
            if (self.holographic == other.holographic && self.my_color != other.my_color) {
                with (other) {
                    if (point_distance(self.x, self.y, other.x, other.y) < (self.radius + other.radius)) {
                        apply_force(other, self.repels);
                    }
                }
            }
        }

        break;


    case shape_rect:

        var left_x = round(x - self.width / 2);
        var right_x = round(x + self.width / 2);
        var top_y = round(y - self.height / 2);
        var bottom_y = round(y + self.height / 2);

        // GUY
        with (guy_obj) {
            if (self.holographic == other.holographic && (self.id == force_field.my_guy || self.my_color != force_field.my_color)) {
                with (other) {
                    var guy = collision_rectangle(left_x, top_y, right_x, bottom_y, other.id, false, true);

                    if (instance_exists(guy)) {
                        if (guy.id != self.my_guy && !guy.stuck) {
                            apply_force(guy, self.repels);
                        }
                    }
                }
            }
        }

        // COLOR PROJECTILES
        with (projectile_obj) {
            if (self.holographic == other.holographic) {
                with (other) {
                    var proj = collision_rectangle(left_x, top_y, right_x, bottom_y, other.id, false, true);

                    if (instance_exists(proj) && proj.my_color != g_dark) {
                        apply_force(proj, self.repels);
                    }
                }
            }
        }

        // AOE
        /*
        with(aoe_obj)
        {
            if(holographic == other.holographic)
            {
                with(other)
                { 
                    aoe = collision_rectangle(left_x,top_y,right_x,bottom_y,other.id,false,true);
                    if(instance_exists(aoe))
                    {
                        apply_force(aoe,repels);
                    }
                    aoe = noone;
                }
            }
        }
        */

        // DARK PROJECTILE
        /*
        with(black_projectile_obj)
        {
            if(holographic == other.holographic)
            {
                with(other)
                { 
                    x_dist = abs(x - other.x);
                    y_dist = abs(y - other.y);
                
                    if((x_dist < width/2+other.radius)
                    && (y_dist < height/2+other.radius))
                    {
                        apply_force(other,repels);
                    }
                }
            }
        }
        */

        // MOBS
        with (mob_obj) {
            if (self.holographic == other.holographic && self.my_color != other.my_color) {
                with (other) {
                    var x_dist = abs(self.x - other.x);
                    var y_dist = abs(self.y - other.y);

                    if ((x_dist < self.width / 2 + other.radius)
                        && (y_dist < self.height / 2 + other.radius)) {
                        apply_force(other, self.repels);
                    }
                }
            }
        }

        break;
}
