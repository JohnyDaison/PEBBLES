event_inherited();

var RuleID = global.RuleID;

/// ANIMATION ENDS AND ENERGY REGEN
if (self.sprite_index != no_sprite && self.image_speed > 0 && self.image_index + self.image_speed >= self.image_number) {
    // ADD TO ORBIT
    if (self.color_added && !self.color_held) {
        self.color_held = true;
        self.color_added = false;
        if (self.my_guy != self.id) {
            my_sound_play(slot_filled_sound);
        }
    }

    // ABSORB
    if (!self.color_held && self.color_consumed && instance_exists(self.my_guy)) //&& !self.color_held
    {
        self.color_consumed = false;
        self.color_held = false;
        self.sprite_index = no_sprite;
        self.image_speed = 0;
        self.invisible = true;
        if (object_is_ancestor(self.my_guy.object_index, guy_obj)) {
            if (self.my_guy.abi_triggered) {
                //self.energy = max(0, self.energy - 0.5);
                // wrong - takes energy even if abi was not success

                orb_transfer(self.id, self.my_guy, "orbit", self.my_guy, "belt");

                self.my_guy.abi_slots_absorbed += 1;
            }
            else {
                if (instance_exists(self.my_guy.charge_ball)) {
                    // CLEAR CHARGEBALL
                    if (self.my_guy.slots_absorbed == 0) {
                        chargeball_orbs_return(self.my_guy.charge_ball);
                    }

                    if (ds_list_size(self.my_guy.charge_ball.orbs) < self.my_guy.charge_ball.max_orbs) {
                        orb_transfer(self.id, self.my_guy, "orbit", self.my_guy.charge_ball, "orbit");
                    }
                    else {
                        orb_transfer(self.id, self.my_guy, "orbit", self.my_guy, "belt");
                    }
                }
                else {
                    orb_transfer(self.id, self.my_guy, "orbit", self.my_guy, "belt");
                }

                self.my_guy.slots_absorbed += 1;

                if (!self.my_guy.is_npc) {
                    my_sound_play(slot_absorbed_sound);
                }
            }

            if (self.my_color == g_octarine) {
                self.my_guy.color_charge[? g_red] += 1;
                self.my_guy.color_charge[? g_green] += 1;
                self.my_guy.color_charge[? g_blue] += 1;
            }
            else {
                self.my_guy.color_charge[? self.my_color] += 1;
            }
        }
    }
}

//self.resonance_level = 0;
self.draw_lightning = false;
self.lightning_target = noone;
self.receives_lightning = false;


// ENERGY REGEN UPDATE
self.energy += self.direct_input_buffer;
self.direct_input_buffer = 0;

var energy_regen_step = min(DB.orb_regen_speeds[? self.cur_regen_speed], max(0, self.base_energy - self.energy));
self.energy += energy_regen_step;

// ENERGY RULES
if (rule_get_state(RuleID.ColorOrbsEnergyMinLock) && self.my_color != g_dark && self.energy < self.base_energy) {
    self.energy = self.base_energy;
}

if (rule_get_state(RuleID.ColorOrbsEnergyLock) && self.my_color != g_dark && self.energy != self.base_energy) {
    self.energy = self.base_energy;
}

if (rule_get_state(RuleID.DarkOrbEnergyLock) && self.my_color == g_dark && self.energy != self.base_energy) {
    self.energy = self.base_energy;
}


if (self.newly_got_steps > 0) {
    self.newly_got_steps -= 1;

    if (self.newly_got_steps == 0) {
        with (overhead_overlay) {
            if (self.my_guy == other.my_guy) {
                self.chborbit_blink_time = self.chborbit_blink_rate * 3;
                self.belts_blink_time = self.belt_blink_rate * 3;
            }
        }
    }
}
