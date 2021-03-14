effect_create_above(ef_firework,x,y,1,tint);
my_sound_play(heal_sound);
var total_boost = hp_boost*stack_size;
var orig_damage = other.damage;
other.damage = max(other.min_damage, other.damage - total_boost);
other.my_player.healed_dmg_total += orig_damage - other.damage;
    
create_text_popup("Health", my_color, id, 0, -48, true);

i = create_damage_popup(total_boost, my_color, id, "health_item");
i.y += 16;

var guy = other;

with(healthbar_overlay)
{
    if(my_guy == guy)
    {
        own_hp_blink_time = own_hp_blink_rate*2;
    }
}