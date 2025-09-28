/// @param {Id.Instance|Asset.GMObject} child
/// @param {Asset.GMObject} parent_index
function object_is_child(child, parent_index) {
    var child_index;

    if (instance_exists(child)) {
        child_index = child.object_index;
    }
    else if (object_exists(child)) {
        child_index = child;
    }
    else {
        return false;
    }

    if (!object_exists(parent_index)) {
        return false;
    }

    return (child_index == parent_index || object_is_ancestor(child_index, parent_index));
}
