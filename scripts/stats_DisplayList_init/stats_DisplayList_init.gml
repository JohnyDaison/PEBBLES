/// @description stats_DisplayList_init(labels, stats)
/// @function stats_DisplayList_init
/// @param labels
/// @param  stats
function stats_DisplayList_init(argument0, argument1) {
	var labels = argument0;
	var stats = argument1;

	var i=0;

	labels[| i]  = "MAIN";
	stats[| i++] = "";

	labels[| i]  = "Score";
	stats[| i++] = "score";
	labels[| i]  = "Score from Achievements";
	stats[| i++] = "achievements_score";
	labels[| i]  = "Damage recieved";
	stats[| i++] = "damage_received";
	labels[| i]  = "Damage dealt";
	stats[| i++] = "damage_dealt";
	labels[| i]  = "Damage healed";
	stats[| i++] = "damage_healed";
	labels[| i]  = "Damage rewound";
	stats[| i++] = "damage_rewound";
	labels[| i]  = "Damage per Action";
	stats[| i++] = "damage_to_actions_ratio";
	labels[| i]  = "Damage per Spell";
	stats[| i++] = "damage_to_spells_ratio";
	labels[| i]  = "Highest APM";
	stats[| i++] = "high_apm";
	labels[| i]  = "Lowest APM";
	stats[| i++] = "low_apm";
	labels[| i]  = "Total jumps";
	stats[| i++] = "jumps";
	labels[| i]  = "on Enemy side(%)";
	stats[| i++] = "percent_on_opponents_half"; // display as *100/singleton_obj.step_count + '%'


	labels[| i]  = "";
	stats[| i++] = "";
	labels[| i]  = "K/D/S";
	stats[| i++] = "";

	labels[| i]  = "Kills";
	stats[| i++] = "kills";
	labels[| i]  = "Personal kills";
	stats[| i++] = "personal_kills";
	labels[| i]  = "Deaths";
	stats[| i++] = "deaths";
	labels[| i]  = "Suicides";
	stats[| i++] = "suicides";

	labels[| i]  = "Longest Killstreak";
	stats[| i++] = "best_killstreak";
	labels[| i]  = "Longest Deathstreak";
	stats[| i++] = "best_deathstreak";


	labels[| i]  = "";
	stats[| i++] = "";
	labels[| i]  = "MOBS & ARTIFACTS";
	stats[| i++] = "";

	labels[| i]  = "Mobs killed";
	stats[| i++] = "mobs_killed_total";
	labels[| i]  = "Mobs killed personally";
	stats[| i++] = "mobs_killed_by_guy";
	labels[| i]  = "Sprinklers killed";
	stats[| i++] = "sprinklers_killed_total";
	labels[| i]  = "Sprinklers killed personally";
	stats[| i++] = "sprinklers_killed_by_guy";
	labels[| i]  = "Slimes killed";
	stats[| i++] = "slimes_killed_total";
	labels[| i]  = "Slimes killed personally";
	stats[| i++] = "slimes_killed_by_guy";
	labels[| i]  = "Artifacts destroyed";
	stats[| i++] = "artifacts_destroyed";


	labels[| i]  = "";
	stats[| i++] = "";
	labels[| i]  = "TURRETS";
	stats[| i++] = "";

	labels[| i]  = "Original";
	stats[| i++] = "starting_turrets";
	labels[| i]  = "Lost";
	stats[| i++] = "turrets_lost";
	labels[| i]  = "Destroyed";
	stats[| i++] = "turrets_destroyed";
	labels[| i]  = "Personally destroyed";
	stats[| i++] = "turrets_destroyed_by_guy";
	labels[| i]  = "Denied";
	stats[| i++] = "turrets_denied";


	labels[| i]  = "";
	stats[| i++] = "";
	labels[| i]  = "TERRAIN";
	stats[| i++] = "";

	labels[| i]  = "Destroyed";
	stats[| i++] = "terrain_destroyed";
	labels[| i]  = "Personally destroyed";
	stats[| i++] = "terrain_destroyed_by_guy";
	labels[| i]  = "Original side total";
	stats[| i++] = "terrain_side_original";
	labels[| i]  = "Original side destroyable";
	stats[| i++] = "terrain_side_original_destroyable";
	labels[| i]  = "Side untouched";
	stats[| i++] = "terrain_side_untouched";


	labels[| i]  = "";
	stats[| i++] = "";
	labels[| i]  = "COLLECTING";
	stats[| i++] = "";

	labels[| i]  = "Crystals";
	stats[| i++] = "crystals_collected";
	labels[| i]  = "Grenades";
	stats[| i++] = "grenades_collected";
	labels[| i]  = "Grenades thrown";
	stats[| i++] = "grenades_thrown";
	labels[| i]  = "Spray cans";
	stats[| i++] = "sprays_collected";
	labels[| i]  = "Spray cans used";
	stats[| i++] = "sprays_used";
	labels[| i]  = "Smoke sprayed";
	stats[| i++] = "smoke_sprayed";
	labels[| i]  = "Orb Batteries";
	stats[| i++] = "batteries_collected";
	labels[| i]  = "Extra Crystals";
	stats[| i++] = "extra_crystals";
	labels[| i]  = "Life Sparks";
	stats[| i++] = "sparks_absorbed";
	labels[| i]  = "Total items used";
	stats[| i++] = "total_items_used";
	labels[| i]  = "Data Cubes";
	stats[| i++] = "secrets_found";


	labels[| i]  = "";
	stats[| i++] = "";
	labels[| i]  = "ORBS";
	stats[| i++] = "";

	labels[| i]  = "Total orbs";
	stats[| i++] = "total_orbs";
	labels[| i]  = "Red";
	stats[| i++] = "red_orbs";
	labels[| i]  = "Green";
	stats[| i++] = "green_orbs";
	labels[| i]  = "Blue";
	stats[| i++] = "blue_orbs";


	labels[| i]  = "";
	stats[| i++] = "";
	labels[| i]  = "COMBAT";
	stats[| i++] = "";

	labels[| i]  = "Cannon shots";
	stats[| i++] = "cannon_shots";
	labels[| i]  = "Spells casted";
	stats[| i++] = "spells";
	labels[| i]  = "Abilities used";
	stats[| i++] = "abilities";
	labels[| i]  = "Channeling time";
	stats[| i++] = "channeling_time";

	labels[| i]  = "LONGEST";
	stats[| i++] = "";
	labels[| i]  = "Spell streak";
	stats[| i++] = "best_spellstreak";
	labels[| i]  = "Ability streak";
	stats[| i++] = "best_abilitystreak";
	labels[| i]  = "Combo";
	stats[| i++] = "best_combo";

	labels[| i]  = "";
	stats[| i++] = "";
	labels[| i]  = "SPELL TYPES";
	stats[| i++] = "";
	labels[| i]  = "Blast";
	stats[| i++] = "blast_count";
	labels[| i]  = "Barrage";
	stats[| i++] = "barrage_count";
	labels[| i]  = "Dash-Wave";
	stats[| i++] = "dashwave_count";
	labels[| i]  = "Shield";
	stats[| i++] = "shield_count";
	labels[| i]  = "Vortex";
	stats[| i++] = "vortex_count";
	labels[| i]  = "Implosion";
	stats[| i++] = "implosion_count";

	labels[| i]  = "";
	stats[| i++] = "";
	labels[| i]  = "COLORS";
	stats[| i++] = "";
	labels[| i]  = "Dark spells";
	stats[| i++] = "spells0";
	labels[| i]  = "Red spells";
	stats[| i++] = "spells1";
	labels[| i]  = "Green spells";
	stats[| i++] = "spells2";
	labels[| i]  = "Blue spells";
	stats[| i++] = "spells4";
	labels[| i]  = "Yellow spells";
	stats[| i++] = "spells3";
	labels[| i]  = "Magenta spells";
	stats[| i++] = "spells5";
	labels[| i]  = "Cyan spells";
	stats[| i++] = "spells6";
	labels[| i]  = "White spells";
	stats[| i++] = "spells7";

	labels[| i]  = "";
	stats[| i++] = "";
	labels[| i]  = "ABILITIES";
	stats[| i++] = "";
	labels[| i]  = "Rewind"; // Black abilities
	stats[| i++] = "abilities0";
	labels[| i]  = "Berserk"; // Red abilities
	stats[| i++] = "abilities1";
	labels[| i]  = "Heal"; // Green abilities
	stats[| i++] = "abilities2";
	labels[| i]  = "Blink"; // Blue abilities
	stats[| i++] = "abilities4";
	labels[| i]  = "Haste"; // Yellow abilities
	stats[| i++] = "abilities3";
	labels[| i]  = "Ubershield"; // Magenta abilities
	stats[| i++] = "abilities5";
	labels[| i]  = "Invisibility"; // Cyan abilities
	stats[| i++] = "abilities6";
	labels[| i]  = "Teleport"; // White abilities
	stats[| i++] = "abilities7";



}
