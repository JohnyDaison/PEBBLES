if (instance_exists(self.my_chunkgrid)) {
    observer_remove(self.my_chunkgrid, self.id);
}

event_inherited();
