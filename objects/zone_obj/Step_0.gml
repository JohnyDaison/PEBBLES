visible = (DB.console_mode == "debug");

if(!in_group && zone_id != "")
{
    group_auto_group(group_id, id, zone_id);
    in_group = true;
}
