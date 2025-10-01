/// @description  REINIT ORBS FROM GUY'S BELTS BASED ON HIS COLOR

if (instance_exists(self.my_guy) && object_is_ancestor(self.my_guy.object_index, guy_obj)) {
    chargeball_orbs_return(self.id);
    guy_orbs_return(self.my_guy);

    chargeball_orbs_draw(self.id);
}
