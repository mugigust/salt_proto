/*
    argument0 = cutscene ID
*/

switch(argument0)
{
    case 0:
    
    break;
    
    case 1:
        instance_create(2026,176,obj_Cutscene1)
        cutsceneID = 0;
    break;
    
    case 2:
        with(obj_Destroyable_Solid)
        {
            if(puzzlePiece)
            {
                y = 460;
                sprite_index = spr_Chantilly_Solid_Sub;
                indestruct = true;
            }
        }
        cutsceneID = 0;
    break
}
