package;

import flixel.FlxSprite;
import flixel.math.FlxMath;
import flixel.math.FlxVelocity;

class Simple extends FlxSprite
{
	var moveSpeed = 200;

	public var player:Player;

	public function new(x:Float, y:Float)
	{
		super(x, y);

		drag.x = 700;

		drag.y = 700;


		makeGraphic(80 + Std.int((Math.random() * 10)-5), 80, FlxColor.RED);
		centerOffsets();
		updateHitbox();
	}

	override public function update(elapsed:Float)
	{

		
	
		
		if (PlayState.player != null){
			FlxVelocity.moveTowardsObject(this, PlayState.player, moveSpeed);
			FlxG.collide(this, PlayState.enemyGroup);

			
		}

	

		super.update(elapsed);

		if (FlxG.overlap(this, PlayState.player))
		{
			//var speed = (Math.abs(PlayState.player.velocity.x) > Math.abs(PlayState.player.velocity.y)) ? Math.abs(PlayState.player.velocity.x) : Math.abs(PlayState.player.velocity.y);

			if ( PlayState.player.isSpeeding)
			{
				this.kill();
			}
		}
	}
}
