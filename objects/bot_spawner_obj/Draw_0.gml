draw_sprite_ext(bot_spawner_spr, 0, x, y, 1, 1, 0, c_white, 1);
draw_sprite_ext(bot_spawner_spr, 1, x, y, 1, 1, 0, tint, 1);

for(var color = g_red; color <= g_blue; color++)
{
    if(color == g_yellow) continue;
    
    var orb = orbs[? color];
    
    draw_sprite_ext(bot_spawner_slot1_spr, 0, orb.x, orb.y, 1, 1, 0, c_white, 1);
    draw_sprite_ext(bot_spawner_slot1_spr, 1, orb.x, orb.y, 1, 1, 0, orb.tint, 1);
}

event_inherited();
