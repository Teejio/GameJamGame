package game;

class Bullet extends FlxSprite {


    var startingdst = 0;

	public function new(x:Float, y:Float, vX:Float, vY:Float)
	{
		super(x, y);

		startingdst = FlxMath.distanceBetween(this, PlayState.player); 

        velocity.x = vX;
        velocity.y = vY;
		makeGraphic(30 + Std.int((Math.random() * 10) - 5), 30 + Std.int((Math.random() * 10) - 5), FlxColor.WHITE);
		centerOrigin();
		centerOffsets();
		updateHitbox();

        PlayState.instance.add(this);
	}


    override public function update(elapsed:Float) {


        super.update(elapsed);


		var dst = FlxMath.distanceBetween(this, PlayState.player);


		if (dst < 80){

            PlayState.player.hurtMe();
            destroy();



        }
		else if ((dst - startingdst) > 1000 ){

            destroy();
        }
    }


}