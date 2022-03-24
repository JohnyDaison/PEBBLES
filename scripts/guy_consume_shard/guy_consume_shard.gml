function guy_consume_shard(shard) {
    var score_gain = shard.stack_size * gamemode_obj.score_values[? "extra_shard"];

    increase_stat(my_player, "extra_shards", shard.stack_size, false);
    increase_stat(my_player, "score", score_gain, false);
    battlefeed_post_pickup(my_player, shard.object_index, score_gain);

    my_sound_play(shard.pickup_sound);
    my_sound_play(heal_sound);

    var orig_damage = damage;
    damage = max(min_damage, damage - shard.stack_size * shard.energy);
    
    if (my_player.my_guy == id) {
        var damage_healed = orig_damage - damage;
        my_player.healed_dmg_total += damage_healed;
    }
    
    // TODO: ORB REPLENISH

    var i = create_damage_popup(-shard.stack_size * shard.energy, my_color, id, "crystal_heal");
    i.y += 16;

    instance_destroy(shard);
}
