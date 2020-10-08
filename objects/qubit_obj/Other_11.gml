effect_create_above(ef_firework,x,y,48,tint);
my_sound_play(qubit_pickup_sound);
other.qubits += 1;
increase_stat(other.my_player, "score", 1, false);