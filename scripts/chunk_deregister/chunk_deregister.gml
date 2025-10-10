/// @param {Id.Instance|Asset.GMObject} gridObj
/// @param {Id.Instance} gameInst
function chunk_deregister(gridObj, gameInst) {
    var gridInst = gridObj.id;

    if (!ds_exists(gridInst.grid, ds_type_grid))
        return false;

    if (is_undefined(gameInst.myChunkArray))
        return false;

    if (gameInst.object_index == data_holder_obj) {
        object_transform(gameInst);
    }

    var myIndex = array_get_index(gameInst.myChunkArray, gameInst.id);
    array_delete(gameInst.myChunkArray, myIndex, 1);

    gameInst.myChunkArray = undefined;

    return true;
}
