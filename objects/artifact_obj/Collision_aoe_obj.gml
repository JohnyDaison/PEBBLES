//show_debug_message("AOE collision");
if(other.force_used > other.force)
    other.force_used = other.force;
dmg = other.force-other.force_used;
if(dmg>0.2)
    dmg = 0.2;
receive_damage(dmg);
event_perform(ev_other,ev_user1);

