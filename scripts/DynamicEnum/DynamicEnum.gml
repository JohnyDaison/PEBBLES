function DynamicEnum() constructor {
    self.dynEnum = {};
    self.nameArray = [];

    static member = function (name) {
        var newMember = is_undefined(self.dynEnum[$ name]);

        if (newMember) {
            self.dynEnum[$ name] = array_length(self.nameArray);

            array_push(self.nameArray, name);
        }

        return self.dynEnum[$ name];
    }

    static getName = function (id) {
        return self.nameArray[id];
    }
}
