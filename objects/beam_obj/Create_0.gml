event_inherited();

self.beam_head_fired = false;
self.beam_head_landed = false;
self.beam_head_delay = 60;
self.alarm[1] = self.beam_head_delay;
self.beam_update_delay = 10;
self.beam_speed = 128;
self.beam_glow_size = 6;
self.beam_small_core_size = 5;
self.beam_big_core_size = 20;
self.beam_tex_glow_start = 4 / 32;
self.beam_tex_glow_end = 11 / 32;
self.beam_nodes = ds_list_create();
self.beam_head_node = 0;
self.beam_head_node_changed = true;
self.beam_head_dist = 0;
self.head_facing = 0;
self.beam_end = noone;
self.alarm[0] = 1;
self.collided = false;
self.endpoint_reached = false;
self.beam_tex = sprite_get_texture(beam_base, 0);
self.beam_high_tex = sprite_get_texture(beam_base_highlight, 0);
self.image_alpha = 0.9;
self.beam_alpha = 0.7;
self.beam_highlight_ratio = 1;
self.beam_draw_phase = 0;
self.small_beam_coef = 300;
self.big_beam_coef = 40;
self.invalid = true;
self.my_ball = noone;
self.my_holder = noone;
self.head_node = noone;
self.facing_right = false;
self.facing = -1;
self.fadeOutStart = 0.3;

self.node_x = 0;
self.next_node_x = 0;

self.radii_updated = false;
self.core_radius = 0;
self.next_core_radius = 0;
self.beam_radius = 0;
self.next_beam_radius = 0;

self.name = "BEAM!!!";

function updateFacing() {
    self.facing = self.facing_right ? 1 : -1;
}

function updateRadii() {
    if (self.beam_draw_phase == 0) {
        self.core_radius      = self.beam_big_core_size / 2;
        self.next_core_radius = self.beam_big_core_size / 2;
    } else if (self.beam_draw_phase == 1) {
        self.core_radius      = self.beam_big_core_size / 2;
        self.next_core_radius = self.beam_small_core_size / 2;
    } else if (self.beam_draw_phase == 2) {
        self.core_radius      = self.beam_small_core_size / 2;
        self.next_core_radius = self.beam_small_core_size / 2;
    }
    
    self.beam_radius      = self.core_radius + self.beam_glow_size;
    self.next_beam_radius = self.next_core_radius + self.beam_glow_size;
}

function finishCasting(guy) {
    guy.casting = false;
    guy.casting_beam = false;
    guy.have_casted = true;
    guy.alarm[0] = guy.spell_cooldown;
}

/// @param {Struct} beamData
function dealDamageSimpleToAll(beamData) {
    self.dealDamageSimple(phys_body_obj, beamData, true, false);
    self.dealDamageSimple(artifact_obj, beamData, false, true);
    self.dealDamageSimple(crystal_obj, beamData, false, true);
}

/// @param {Asset.GMObject} targetObj
/// @param {Struct} beamData
/// @param {Bool} ignoreSamePlayer
/// @param {Bool} triggerUserEvent
function dealDamageSimple(targetObj, beamData, ignoreSamePlayer, triggerUserEvent) {
    with (targetObj) {
        if (ignoreSamePlayer && self.my_player == other.my_player) {
            continue;
        }

        if (collision_rectangle(beamData.x1, beamData.y1, beamData.x2, beamData.y2, self.id, false, false) != noone) {
            receive_damage(beamData.damage, beamData.isBig);

            if (triggerUserEvent) {
                event_perform(ev_other, ev_user1);
            }
        }
    }
}

/// @param {Asset.GMObject} targetObj
/// @param {Struct} bigBeamData
/// @param {Struct} smallBeamData
/// @param {Bool} ignoreSamePlayer
/// @param {Bool} triggerUserEvent
/// @param {Bool} facingCondition
function dealDamageBeamHead(targetObj, bigBeamData, smallBeamData, ignoreSamePlayer, triggerUserEvent, facingCondition) {
    with (targetObj) {
        if (ignoreSamePlayer && self.my_player == other.my_player) {
            continue;
        }

        if (collision_rectangle(bigBeamData.x1, bigBeamData.y1, bigBeamData.x2, bigBeamData.y2, self.id, false, false) != noone) {
            receive_damage(bigBeamData.damage, bigBeamData.isBig);

            if (triggerUserEvent) {
                event_perform(ev_other, ev_user1);
            }
        }

        if (!facingCondition) {
            continue;
        }

        if (collision_rectangle(smallBeamData.x1, smallBeamData.y1, smallBeamData.x2, smallBeamData.y2, self.id, false, false) != noone) {
            receive_damage(smallBeamData.damage, smallBeamData.isBig);

            if (triggerUserEvent) {
                event_perform(ev_other, ev_user1);
            }
        }
    }
}
