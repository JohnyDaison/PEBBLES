/// @param {String} name
/// @param {Constant.DsType|String} type
/// @param {Id.DsList|Id.DsMap|Id.DsGrid} dsId
/// @param {Id.Instance} instance
function DsRegistryEntry(name, type, dsId, instance) constructor {
    self.name = name;
    self.type = type;
    self.id = dsId;
    self.instance = noone;
    self.objectName = "invalid";

    if (instance_exists(instance)) {
        self.instance = instance;
        self.objectName = object_get_name(instance.object_index);
    }
}
