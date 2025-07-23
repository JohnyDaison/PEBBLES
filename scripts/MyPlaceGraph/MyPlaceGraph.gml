function MyPlaceGraph() : MyGraph() constructor {
    last_connection_id = 0;
    
    /// @function add_node
    /// @param {String} node_id
    /// @param {Id.Instance} _place
    /// @param {String} _zone_id
    /// @return {Bool}
    static add_node = function(node_id, _place, _zone_id) {
        var existing = nodes[? node_id];
        var place_id = _place.id;
        
        if (!is_undefined(existing)) {
            my_console_log("Node " + node_id + " already exists");
            return false;
        }
        
        var matching_node = find_node(place_id, _zone_id);
        
        if (!is_undefined(matching_node)) {
            my_console_log("Node " + node_id + "is identical to " +  matching_node);
            return false;
        }
        
        nodes[? node_id] = {place: place_id, zone_id: _zone_id};
        ds_list_add(node_list, node_id);
        
        return true;
    }
    
    /// @function find_node
    /// @param {Id.Instance} _place
    /// @param {String} _zone_id
    /// @return {String|undefined}
    static find_node = function(_place, _zone_id) {
        var count = ds_list_size(node_list);
        var place_id = _place.id;
        
        for (var node_i = 0; node_i < count; node_i++) {
            var node_id = node_list[| node_i];
            var node = nodes[? node_id];
            
            if (node.place == place_id && node.zone_id == _zone_id) {
                return node_id;
            }
        }
        
        return undefined;
    }
    
    /// @function add_connection
    /// @param {String} from_node_id
    /// @param {String} to_node_id
    /// @return {Bool}
    static add_connection = function(from_node_id, to_node_id) {
        var connection_id = string(last_connection_id++);
        
        var from_node = nodes[? from_node_id];
        var to_node = nodes[? to_node_id];
        
        if (is_undefined(from_node)) {
            my_console_log("Connection " + connection_id + " - From node " + from_node_id + " doesn't exist");
            return false;
        }
        
        if (is_undefined(to_node)) {
            my_console_log("Connection " + connection_id + " - To node " + to_node_id + " doesn't exist");
            return false;
        }
        
        var matching_connection = find_connection(from_node_id, to_node_id);
        
        if (!is_undefined(matching_connection)) {
            my_console_log("Connection " + connection_id + " is identical to " +  matching_connection + " (" + from_node_id + " - " + to_node_id + ")");
            return false;
        }
        
        var same_from_connection = find_connection(from_node_id);
        
        if (!is_undefined(same_from_connection)) {
            my_console_log("Connection " + connection_id + "is coming from same node as " +  same_from_connection + " (" + from_node_id + ")");
            return false;
        }
        
        connections[? connection_id] = {from: from_node_id, to: to_node_id};
        ds_list_add(connection_list, connection_id);
        
        return true;
    }
    
    /// @function find_connection
    /// @param {String} from_node_id
    /// @param {String} to_node_id
    /// @return {String|undefined}
    static find_connection = function(from_node_id, to_node_id) {
        var count = ds_list_size(connection_list);
        
        for (var conn_i = 0; conn_i < count; conn_i++) {
            var conn_id = connection_list[| conn_i];
            var connection = connections[? conn_id];
            
            if ((is_undefined(from_node_id) || connection.from == from_node_id) 
                && (is_undefined(to_node_id) || connection.to == to_node_id)) {
                return conn_id;
            }
        }
        
        return undefined;
    }
}
