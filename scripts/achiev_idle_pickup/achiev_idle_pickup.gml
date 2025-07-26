function achiev_idle_pickup(query) {
    switch (query) {
        case "title": {
            return "Idle Recipient";
        }

        case "verb": {
            return "was delivered something";
        }

        case "success": {
            if (instance_exists(my_guy)) {
                return my_guy.idle && my_guy.idle_start < (my_guy.last_added_item_step - 300);
            }

            return false;
        }

        case "fail": {
            return false;
        }

        case "reward": {
            return true;
        }
    }
}
