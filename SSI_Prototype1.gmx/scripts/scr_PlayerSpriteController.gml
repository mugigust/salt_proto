
//argument0 == Salt's actual form ID

if(formID == 0)
{
    if(bellyFull)
    {
        idleSprite = spr_FatSalt_Idle;
        walkingSprite = spr_FatSalt_Walking;
        jumpingSprite = spr_FatSalt_Jumping;
        attack1Sprite = spr_Salt_Spit;
        attack2Sprite = spr_Salt_Spit;
        crouchSprite = spr_Salt_Transforming;
    }
    else
    {
        idleSprite = spr_Salt_Idle;
        walkingSprite = spr_Salt_Walking;
        jumpingSprite = spr_Salt_Jumping;
        attack1Sprite = spr_Salt_Chomp;
        attack2Sprite = spr_Salt_Chomp;
        crouchSprite = spr_Salt_Transforming;
    }
}
if(formID = 1)
{
    idleSprite = spr_FireSalt_Idle;
    walkingSprite = spr_FireSalt_Walking;
    jumpingSprite = spr_Salt_Jumping;
    attack1Sprite = spr_FireSalt_SideAttack;
    attack2Sprite = spr_Salt_Chomp;
    crouchSprite = spr_Salt_Transforming;
}
