/// @description START-UP GUY SPAWNERS / CREATE ALL THE THINGS

with (guy_spawner_obj) {
    self.enabled = true;
}

// this is not completely correct, some turrets could be data_holder_obj by this time
with (turret_obj) {
    increase_stat(self.my_player, "starting_turrets", 1, false);
}

var pl = 1;
var start_found = false;
var ordered_starts = ds_map_create();

with (level_start_obj) {
    if (self.for_player == -1) {
        self.my_player = gamemode_obj.players[? pl++];
    }
    else {
        self.my_player = gamemode_obj.players[? self.for_player];
    }

    if (is_undefined(self.my_player)) {
        self.my_player = noone;
        instance_destroy();
        continue;
    }

    self.activated = true;

    ordered_starts[? self.my_player.number] = self.id;

    start_found = true;
}

for (var playerNumber = 1; playerNumber <= self.player_count; playerNumber++) {
    var level_start = ordered_starts[? playerNumber];

    if (is_undefined(level_start)) {
        continue;
    }

    with (level_start) {
        create_player_things(self.my_player);
    }
}

ds_map_destroy(ordered_starts);

self.alarm[1] = 20;

if (!start_found && instance_exists(guy_spawner_obj)) {
    self.alarm[1] = guy_spawner_obj.first_spawn_time;
}
