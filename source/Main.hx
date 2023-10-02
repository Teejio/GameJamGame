package;

import flixel.FlxGame;
import openfl.display.Sprite;
import openfl.events.UncaughtErrorEvent;
import haxe.CallStack;
import openfl.Lib;
import haxe.io.Path;
import sys.FileSystem;
import sys.io.File;
import sys.io.Process;
import lime.app.Application;

class Main extends Sprite
{
	public function new()
	{
		super();
		Application.current.window.resizable = false;
		addChild(new FlxGame(0, 0, TitleState, 60,60,true,false));
	}

	

	
}

