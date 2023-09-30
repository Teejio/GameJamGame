package;
import flixel.FlxSprite;


class Player extends FlxSprite{


    var movement:Int = 0;
    var movementy:Int = 0;
    public function new(x:Float, y:Float)
        {

            super(x,y);

            drag.x = 800;

            drag.y = 600;
            makeGraphic(100,100, FlxColor.GREEN);
            centerOffsets();
            updateHitbox();


        }

        override public function update(elapsed:Float) {

            super.update(elapsed);

            movement = 0;
            movementy = 0;

            if (FlxG.keys.anyPressed([A, LEFT])) {

                movement -= 1;
            }
            if (FlxG.keys.anyPressed([D, RIGHT])) {

                movement += 1;
            }
            
            if (FlxG.keys.anyPressed([W, UP])) {

                movementy -= 1;
            }
            if (FlxG.keys.anyPressed([S, DOWN])) {

                movementy += 1;
            }

            velocity.x += movement * 1000 * elapsed;
            velocity.y += movementy * 1000 * elapsed;

   
        }
}