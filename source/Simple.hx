package;

import flixel.FlxSprite;
import flixel.math.FlxMath;
import flixel.math.FlxVelocity;

class Simple extends FlxSprite
{
	var moveSpeed = 2;

	public var player:Player;

	public function new(x:Float, y:Float)
	{
		super(x, y);

		//  drag.x = 700;

		//   drag.y = 700;
		makeGraphic(Std.int(x), Std.int(y), FlxColor.RED);
		centerOffsets();
		updateHitbox();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		var playerPosX = player.x;
		var playerPosY = player.y;

		FlxVelocity.moveTowardsObject(this, player, moveSpeed);
	}
}
