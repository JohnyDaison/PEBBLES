/// @param {Asset.GMObject|Id.Instance} pickup
/// @return {Id.Instance}
function find_in_inventory(pickup) {
    var byId = false;

    if (!instance_exists(pickup)) {
        return noone;
    }

    var pickupIndex = pickup.object_index;
    var pickupId = pickup.id;

    if (pickup == pickupId) {
        byId = true;
    }

    for (var index = 1; index <= self.inventory_size; index++) {
        var item = self.inventory[? index];

        if (!instance_exists(item)) {
            continue;
        }

        if (item.object_index == pickupIndex && (!byId || item.id == pickupId)) {
            return item;
        }
    }

    return noone;
}
