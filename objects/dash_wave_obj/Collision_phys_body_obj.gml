if(!fading_out && other.holographic == self.holographic)
{
    with(other)
    {
        if(receive_damage(other.force))
        {
            other.dealt_damage = true;
        }
    }
    has_collided = true;
}
