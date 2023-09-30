package backend;

import flixel.graphics.frames.FlxAtlasFrames;



class Paths {

	inline  public static function image(name:String , ?pathName:Null<String> = null){

		return gimmePath('images/$name.png', pathName);        
    }

	inline  public static function xml(name:String, ?pathName:Null<String> = null)
	{
		trace(FlxAtlasFrames.fromSparrow(image(name, pathName), gimmePath('images/$name.xml', pathName)));
		return FlxAtlasFrames.fromSparrow(image(name, pathName), gimmePath('images/$name.xml', pathName));
	}


	public static function gimmePath(name:String, ?pathName:Null<String> = null){

		if (pathName != null)
        {
			return pathName + '/' + name;
        }
        else{
			return 'assets/' + name;
		}

        


    }
}