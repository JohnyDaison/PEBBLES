if(time_limit > 0)
{
    self.text = seconds_to_time_str(time_limit - total);
}
else
{
    self.text = seconds_to_time_str(total);    
}