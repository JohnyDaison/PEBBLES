if(!destroyed && other.my_player != my_guy.my_player)
{
    if(other.force_used > other.force)
        other.force_used = other.force;
    var dmg = other.force-other.force_used;
    if(dmg>0.2)
        dmg = 0.2;
    receive_damage(dmg);
}

