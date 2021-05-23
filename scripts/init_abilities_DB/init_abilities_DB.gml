function init_abilities_DB() {
    // BASE ABILITY COOLDOWNS
    abi_cooldowns = ds_map_create();
    abi_cooldowns[? g_dark] = 7200;
    abi_cooldowns[? g_red] = 2220;
    abi_cooldowns[? g_green] = 2700;
    abi_cooldowns[? g_blue] = 900;
    abi_cooldowns[? g_yellow] = 1600;
    abi_cooldowns[? g_magenta] = 1620;
    abi_cooldowns[? g_cyan] = 4200;
    abi_cooldowns[? g_white] = 36000;
    
    // MAP OF GAME COLORS TO ABILITIES
    abimap = ds_map_create();
    abimap[? -1] =   "self_destruct";
    abimap[? g_dark] =   "rewind";
    abimap[? g_red] =  "berserk";
    abimap[? g_green] =  "heal";
    abimap[? g_blue] =  "teleport";
    abimap[? g_yellow] =  "haste";
    abimap[? g_magenta] =  "ubershield";
    abimap[? g_cyan] =  "invisibility";
    abimap[? g_white] =  "base_teleport";

    abi_name_map = ds_map_create();
    abi_name_map[? -1] =   "Self destruct";
    abi_name_map[? g_dark] =   "Rewind";
    abi_name_map[? g_red] =  "Berserk";
    abi_name_map[? g_green] =  "Heal";
    abi_name_map[? g_blue] =  "Blink";
    abi_name_map[? g_yellow] =  "Haste";
    abi_name_map[? g_magenta] =  "Ubershield";
    abi_name_map[? g_cyan] =  "Invisibility";
    abi_name_map[? g_white] =  "Teleport";

    abi_description_map = ds_map_create();
    abi_description_map[? -1] =   "End your existence.";
    abi_description_map[? g_dark] =   "Go 2 seconds back in time.";
    abi_description_map[? g_red] =  "Charge spells faster.";
    abi_description_map[? g_green] =  "Regenerate HP over time.";
    abi_description_map[? g_blue] =  "Instantly appear elsewhere.";
    abi_description_map[? g_yellow] =  "Run faster.";
    abi_description_map[? g_magenta] =  "Double your Shield or create new one.";
    abi_description_map[? g_cyan] =  "Make Turrets, Mobs and NPCs ignore you.";
    abi_description_map[? g_white] =  "Return to Base.";

    abi_icons = ds_map_create();
    abi_icons[? -1] =   selfdestruct_icon;
    abi_icons[? g_dark] =   flashback_icon;
    abi_icons[? g_red] =  berserk_icon;
    abi_icons[? g_green] =  heal_icon;
    abi_icons[? g_blue] =  teleport_icon;
    abi_icons[? g_yellow] =  haste_icon;
    abi_icons[? g_magenta] =  ubershield_icon;
    abi_icons[? g_cyan] =  invisibility_icon;
    abi_icons[? g_white] =  chaos_drive_icon;
}
