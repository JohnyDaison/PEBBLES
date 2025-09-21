if (other.my_guy == other.id) {
    other.my_guy = self.id;
    ds_list_add(self.stolen_slots, other.id);
    self.slot_count = ds_list_size(self.stolen_slots);
}
