if(other.my_guy == other.id)
{
    other.my_guy = self.id;
    ds_list_add(stolen_slots,other.id);
    slot_count = ds_list_size(stolen_slots);
}

