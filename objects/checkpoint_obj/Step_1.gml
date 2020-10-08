/// @description HOLOGRAPHIC

// HOLOGRAPHIC
if(holographic)
{
    holo_alpha += holo_alpha_step;
    
    if(holo_alpha < holo_minalpha)
    {
        holo_alpha = holo_minalpha;
        holo_alpha_step *= -1;
    }
    
    if(holo_alpha > holo_maxalpha)
    {
        holo_alpha = holo_maxalpha;
        holo_alpha_step *= -1;
    }
}