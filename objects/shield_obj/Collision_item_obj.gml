/// @description SHOCKWAVE mode
if(my_guy == id && !other.collected && !other.immovable && other.id != source_id && holographic == other.holographic)
{
    apply_force(other.id, true);
}
