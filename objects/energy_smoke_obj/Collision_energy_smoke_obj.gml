if(my_color == other.my_color && my_guy == other.my_guy && holographic == other.holographic
&& !consolidated && speed < 0.5 && other.speed < 0.5)
{
    //other.force = mean(force, other.force);
    other.force += force;
    other.consolidated = true;
    other.x = mean(other.x, x);
    other.y = mean(other.y, y);
    instance_destroy();
}

