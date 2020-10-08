function guy_die_from_damage() {
    die_from_damage = function() {
        self.lost_control = true;
        self.protected = true;
        
        // DROP RESERVE ORBS
        drop_reserve_orbs();
        
        // DROP ITEMS
        drop_all_items();
        
        
        // DROP ALL EQUIPMENT
        body_unequip_all(id);
        
        // EXPLOSION
        var explo = instance_create(x,y,slot_explosion_obj);   
        explo.my_color = my_color;
        explo.my_player = my_player;
        explo.my_guy = id;
        explo.my_source = guy_obj;
        explo.fire_projectiles = false;
        explo.energy = damage;
        
        // CAMERA PLACE HOLDER
        place_holder = instance_create(x,y,place_holder_obj);
        place_holder.my_player = my_player;
        //my_player.my_camera.my_guy = place_holder;
        if(instance_exists(my_player.my_camera))
        {
            my_player.my_camera.my_guy = place_holder;
            my_player.my_camera.follow_spawner = true;
        }
    }
}