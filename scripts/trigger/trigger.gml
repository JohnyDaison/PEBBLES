/// @param {Id.Instance|Asset.GMObject} target
/// @param ...
function trigger(target) {
    var retval = false;
    var log_str = "TRIGGER ";
    var doLogging = false;

    if (!instance_exists(target)) {
        return false;
    }

    if (doLogging) {
        log_str += object_get_name(target.object_index) + " ";
    }

    if (target.triggerable) {
        var args = [0];

        if (doLogging) {
            log_str += script_get_name(target.trigger_script) + " ";
        }

        for (var i = 1; i < argument_count; i++) {
            args[i - 1] = argument[i];
            
            if (doLogging) {
                log_str += string(args[i - 1]) + " ";
            }
        }
        
        var count = argument_count - 1;

        with (target) {
            retval = script_execute(self.trigger_script, count, args);
        }
    }

    if (doLogging) {
        my_console_log(log_str);
    }

    return retval;
}
