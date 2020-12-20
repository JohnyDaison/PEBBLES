/// @description init_stats(player, stats_map)
/// @function init_stats
/// @param player
/// @param stats_map
function init_stats() {

	var player = argument[0];
	var stats = argument[1];

	with(player)
	{
	    // DAMAGE STATS
	    spell_dmg_total = 0
	    wall_dmg_total = 0;
	    burn_dmg_total = 0;
	    dealt_dmg_total = 0;
	    healed_dmg_total = 0;
	    rewound_dmg_total = 0;
	}


	stats[? "score"] = 0;
	stats[? "achievements_score"] = 0;
	stats[? "damage_received"] = 0;
	stats[? "damage_dealt"] = 0;
	stats[? "damage_healed"] = 0;
	stats[? "damage_rewound"] = 0;
	stats[? "percent_on_opponents_half"] = 0;  // = time_on_opponents_half*100/singleton_obj.step_count
	stats[? "high_apm"] = 0;
	stats[? "low_apm"] = 0;
	stats[? "jumps"] = 0;
	stats[? "damage_to_actions_ratio"] = 0;
	stats[? "damage_to_spells_ratio"] = 0;
    stats[? "attack_color_efficiency"] = 0;
	stats[? "defense_color_efficiency"] = 0;
    stats[? "hit_count"] = 0;
    stats[? "received_hits"] = 0;

	stats[? "kills"] = 0;
	stats[? "personal_kills"] = 0;
	stats[? "deaths"] = 0;
	stats[? "suicides"] = 0;

	stats[? "best_killstreak"] = 0;
	stats[? "best_deathstreak"] = 0;

	stats[? "mobs_killed_total"] = 0;
	stats[? "mobs_killed_by_guy"] = 0;
	stats[? "sprinklers_killed_total"] = 0;
	stats[? "sprinklers_killed_by_guy"] = 0;
	stats[? "slimes_killed_total"] = 0;
	stats[? "slimes_killed_by_guy"] = 0;

	stats[? "artifacts_destroyed"] = 0;

	stats[? "starting_turrets"] = 0;
	stats[? "turrets_destroyed"] = 0;
	stats[? "turrets_destroyed_by_guy"] = 0;
	stats[? "turrets_lost"] = 0;
	stats[? "turrets_denied"] = 0;

	stats[? "terrain_destroyed"] = 0;
	stats[? "terrain_destroyed_by_guy"] = 0;
	stats[? "terrain_side_original"] = 0;
	stats[? "terrain_side_original_destroyable"] = 0;
	stats[? "terrain_side_untouched"] = 0;

	stats[? "crystals_collected"] = 0;
	stats[? "grenades_collected"] = 0;
	stats[? "grenades_thrown"] = 0;
	stats[? "sprays_collected"] = 0;
	stats[? "sprays_used"] = 0;
	stats[? "smoke_sprayed"] = 0;
	stats[? "batteries_collected"] = 0;
	stats[? "extra_crystals"] = 0;
	stats[? "sparks_absorbed"] = 0;
	stats[? "total_items_used"] = 0;

	stats[? "total_orbs"] = 0;
	stats[? "red_orbs"] = 0;
	stats[? "green_orbs"] = 0;
	stats[? "blue_orbs"] = 0;
	stats[? "cannon_shots"] = 0;

	stats[? "spells"] = 0;
	stats[? "abilities"] = 0;
	stats[? "channeling_time"] = 0;
	stats[? "best_spellstreak"] = 0;
	stats[? "best_abilitystreak"] = 0;
	stats[? "best_combo"] = 0;

	stats[? "secrets_found"] = 0;

	stats[? "blast_count"] = 0;
	stats[? "barrage_count"] = 0;
	stats[? "dashwave_count"] = 0;
	stats[? "shield_count"] = 0;
	stats[? "vortex_count"] = 0;
	stats[? "implosion_count"] = 0;

	stats[? "spells0"] = 0;
	stats[? "spells1"] = 0;
	stats[? "spells2"] = 0;
	stats[? "spells3"] = 0;
	stats[? "spells4"] = 0;
	stats[? "spells5"] = 0;
	stats[? "spells6"] = 0;
	stats[? "spells7"] = 0;

	stats[? "abilities0"] = 0;
	stats[? "abilities1"] = 0;
	stats[? "abilities2"] = 0;
	stats[? "abilities3"] = 0;
	stats[? "abilities4"] = 0;
	stats[? "abilities5"] = 0;
	stats[? "abilities6"] = 0;
	stats[? "abilities7"] = 0;


	// DON'T DISPLAY - TEMP VALUES
	stats[? "time_on_opponents_half"] = 0;
	stats[? "actions"] = 0;
	stats[? "total_actions"] = 0;
	stats[? "killstreak"] = 0;
	stats[? "deathstreak"] = 0;
	stats[? "spellstreak"] = 0;
	stats[? "abilitystreak"] = 0;
	stats[? "combo"] = 0;
    stats[? "attack_color_ratio_total"] = 0;
	stats[? "defense_color_ratio_total"] = 0;
}
