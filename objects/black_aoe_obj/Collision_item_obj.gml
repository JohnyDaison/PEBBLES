if(other.my_guy == other.id && other.collectable && !other.collected && !instance_exists(other.my_shield))
{
    other.my_guy = self.id;
}

