if(!destroyed && other.my_player != my_player && !other.fading_out && other.holographic == self.holographic)
{
    if(receive_damage(other.force))
    {
        other.dealt_damage = true;
    }
    other.has_collided = true;
}

