/// @param {Id.Instance} pickup
/// @param {Bool} only_count default = false
function add_to_inventory(pickup, only_count = false) {
    var item_count = 0, free_slot = -1;
    var got_one = false;
    var stacking = false;

    var added = 0, stack_left = 0, stack_part;

    if (!instance_exists(pickup)) {
        return 0;
    }

    if (pickup.collected || pickup.used || holographic != pickup.holographic || pickup.newly_dropped_guy == self.id) {
        return 0;
    }

    // CONSUMING CRYSTALS
    if (pickup.object_index == crystal_obj) {
        if (crystal_will_be_consumed()) {
            added = pickup.stack_size;

            if (!only_count) {
                guy_consume_shard(pickup);
            }

            if (added > 0) {
                self.last_added_item_step = self.step_count;
            }

            return added;
        }
    }

    // NORMAL PICKUP

    // HANDLE RESERVATIONS
    var reserved_slot = 0;

    for (var index = 1; index <= self.inventory_size; index++) {
        if (pickup.object_index == self.inv_reserved[? index]) {
            reserved_slot = index;
        }
    }

    var start_item = 0, end_item = 0;

    if (reserved_slot == 0) {
        start_item = 1;
        end_item = self.inventory_size;
    }
    else {
        start_item = reserved_slot;
        end_item = reserved_slot;
    }

    // STACK OR ASSIGN SLOT
    stack_left = pickup.stack_size;

    for (var index = start_item; index <= end_item; index++) {
        var item = self.inventory[? index];

        if (instance_exists(item)) {
            item_count++;

            if (item.object_index == pickup.object_index && item.name == pickup.name) {
                got_one = true;

                if (item.stack_size < item.max_stack_size && item.my_color == pickup.my_color) {
                    stacking = true;
                    stack_part = min(item.max_stack_size - item.stack_size, stack_left);

                    if (!only_count) {
                        if (item.stack_size == 0) {
                            item.newly_got_steps = item.newly_got_anim_duration;
                        }

                        item.stack_size += stack_part;
                        pickup.stack_size -= stack_part;

                        if (pickup.fresh && instance_exists(pickup_spawner_obj)) {
                            pickup_spawner_obj.spawned_item_count -= stack_part;
                        }
                    }

                    stack_left -= stack_part;

                    added += stack_part;

                }
            }
        }
        else if (free_slot == -1
            && (self.inv_reserved[? index] == noone || self.inv_reserved[? index] == pickup.object_index)) {
            free_slot = index;
        }
    }


    if ((free_slot != -1 || stacking) && !(pickup.unique && got_one)) {
        // PICKUP EFFECT
        if (!pickup.reserved && !only_count) {
            effect_create_above(ef_firework, pickup.x, pickup.y, 48, pickup.tint);

            my_sound_play(pickup.pickup_sound);

            if (pickup.pickup_show_name) {
                var popup = instance_create(pickup.x, pickup.y - 16, text_popup_obj);

                popup.str = pickup.name;
                popup.my_color = pickup.my_color;
                popup.tint_updated = false;
            }

            pickup.newly_got_steps = pickup.newly_got_anim_duration;
        }


        if (!stacking) {
            // NEW ITEM TO FREE SLOT
            if (!only_count) {
                pickup.my_guy = self.id;
                self.inventory[? free_slot] = pickup.id;
                pickup.inv_index = free_slot;
                self.inv_curr_index = free_slot;

                pickup.visible = false;
                pickup.collected = true;
                pickup.alarm[0] = -1;
                pickup.step = 0;
                pickup.light_yoffset = 0;
                pickup.hover_offset = 0;
                pickup.my_player = self.my_player;

                if (pickup.fresh && instance_exists(pickup_spawner_obj)) {
                    pickup_spawner_obj.spawned_item_count -= pickup.stack_size;
                }

                pickup.fresh = false;
            }

            added = pickup.stack_size;
        }
        else {
            // STACKED, DESTROY PICKUP
            if (pickup.stack_size <= 0) {
                instance_destroy(pickup);
            }
        }
    }
    else {
        // "INVENTORY FULL" EFFECT
        self.full_inv_blink = true;
    }

    if (added > 0) {
        self.last_added_item_step = self.step_count;
    }

    return added;
}
