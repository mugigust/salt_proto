
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
    if(onGround)
    {
        if(sprite_index != attack1Sprite)
        {
            sprite_index = attack1Sprite;
            image_index = 0;
        }
        image_speed = 0.3;
        if(image_index > 2 && image_index < 3)
        {
            instance_create(x,y,obj_Attack);
            with(obj_Attack)
            {
                mask_index = spr_FireSalt_SideAttackMask;
            }
        }
        if(image_index > 9)
        {
            with(obj_Attack)
                instance_destroy();
            control = true;
            image_speed = 0;
            attacking = false;
        }
    }
    else
    {
        onGrav = false;
        if(sprite_index != attack2Sprite)
        {
            sprite_index = attack2Sprite;
            image_index = 0;
        }
        invincible = true;
        image_speed = 0.3;
        vspd = 0;
        hspd = facing * (2*spd);
        if(image_index > 7)
        {
            onGrav = true;
            control = true;
            image_speed = 0;
            attacking = false;
            invincible = false;
        }
    }
}
