//show_debug_message("equipment AOE collision");
if (other.force_used > other.force) {
    other.force_used = other.force;
}

var dmg = other.force - other.force_used;

if (dmg > 0.2) {
    dmg = 0.2;
}

receive_damage(dmg);
