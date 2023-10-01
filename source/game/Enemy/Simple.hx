package game.enemy;

import flixel.FlxSprite;
import flixel.math.FlxMath;
import flixel.math.FlxVelocity;

class Simple extends Enemy
{


	


	public function new(x:Float, y:Float, colorA:Int)
	{
		super(x, y, colorA);

		moveSpeed = 200;
	}

	
	
}
