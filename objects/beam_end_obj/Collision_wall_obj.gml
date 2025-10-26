if (!instance_exists(self.my_beam)) {
    instance_destroy();
    exit;
}

var power_ratio = get_power_ratio(self.my_beam.my_color, other.my_color);

if (power_ratio == 0) {
    exit;
}

var body_dmg = power_ratio * (self.my_beam.force / self.my_beam.big_beam_coef);

other.energy += abs(body_dmg);
other.beam_end_met = true;

if ((other.damage + body_dmg) < 0) {
    body_dmg = -other.damage;
}

if (body_dmg == 0) {
    exit;
}

other.my_next_color = self.my_beam.my_color;
other.tint = self.my_beam.tint;
other.damage += body_dmg;
other.last_dmg += body_dmg;

// TODO: This popup has tint set directly, which is not supported by create_damage_popup
var inst = instance_create(other.x, other.y, damage_popup_obj);

inst.damage = body_dmg;
inst.my_color = self.my_beam.my_color;
inst.tint = DB.colormap[? inst.my_color];
inst.tint_updated = true;
inst.source = other.id;
