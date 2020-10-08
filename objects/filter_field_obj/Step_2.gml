// PULSING
alpha += alpha_dir*alpha_speed;
if(alpha_dir == -1)
{
    if(alpha <= min_alpha)
    {
        alpha = min_alpha;
        alpha_dir = 1;
    }   
}
else if (alpha_dir == 1)
{
    if(alpha >= max_alpha)
    {
        alpha = max_alpha;
        alpha_dir = -1;
    }
}

ambient_light = alpha/4;

// COLOR UPDATE
new_col = my_projectors[? 1].my_color & my_projectors[? 2].my_color;
if(new_col <= g_black || new_col >= g_octarine)
{
    instance_destroy();   
    exit;
}

if(new_col != my_color)
{
    my_color = new_col;
    tint_updated = false;
}

// POSITION AND DIMENSIONS UPDATE
if(!ready)
{
    x1 = min(my_projectors[? 1].x, my_projectors[? 2].x) -1;
    x2 = max(my_projectors[? 1].x, my_projectors[? 2].x) -1;
    
    y1 = min(my_projectors[? 1].y, my_projectors[? 2].y);
    y2 = max(my_projectors[? 1].y, my_projectors[? 2].y);
    
    x = ceil(mean(x1, x2));
    y = ceil(mean(y1, y2));
    
    x1 = floor(x1) -14;
    y1 = floor(y1) -15;
    x2 = ceil(x2) +14;
    y2 = ceil(y2) +13;
    
    width = x2-x1;
    height = y2-y1;
    
    radius = max(width, height)/2;
    
    image_xscale = (width + 2*check_dist)/mask_size;
    image_yscale = (height + 2*check_dist)/mask_size;
    
    ready = true;
}

event_inherited();