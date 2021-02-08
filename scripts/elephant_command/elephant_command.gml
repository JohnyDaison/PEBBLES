function elephant_command() {
    var elephant_found = false;
    
    with(menu_elephant_obj) {
        alarm[11] = 1;
        elephant_found = true;
    }
    
    if(elephant_found) {
        return "Toot!";
    } else {
        return "The elephant is not in this room.";
    }
}