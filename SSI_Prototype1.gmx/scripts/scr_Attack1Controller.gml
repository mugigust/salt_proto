
//argument0 = ID do PowerUp

if(argument0 == 0)
{
    if(!bellyFull)
    {
        sprite_index = attack1Sprite;
        hspd = (spd * facing) * 1.8;
        
        if(image_index > 5)
        {
            image_speed = 0;
            hspd = 0;
        }
    }
    else if(!eating)
    {
        control = false;
        sprite_index = attack2Sprite;
        image_speed = 0.3;
        if(image_index > 4 && !spit_out)
        {
            spit_out = true;
            with(instance_create(x+(20*facing),y,obj_Spit))
            {
                facing = other.facing;
            }
        }
        if(image_index > 6)
        {
            image_speed = 0;
            spit = false;
            bellyFull = false;
            control = true;
            spit_out = false;
            
        }
    }
}
if(argument0 == 1)
{
    control = false;
    sprite_index = attack1Sprite;
    image_speed = 0.3;
    if(image_index > 9)
    {
        control = true;
        image_speed = 0;
        attacking = false;
    }
}
