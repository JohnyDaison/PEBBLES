fade -= fade_rate;

if(fade <= 0)
{
    instance_destroy();
}

