package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;

/**
 * ...
 * @author ...
 */
class Nube extends FlxSprite
{

	public function new(tipoNube:Int,?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		switch (tipoNube)
		{
			case 0:
			{
				loadGraphic(AssetPaths.Nube1__png);
				
			}
			case 1:
			{
				loadGraphic(AssetPaths.Nube2__png);
				
			}
			case 2:
			{
				loadGraphic(AssetPaths.Nube3__png);
				
			}

		}
		scale.x = 2;
		scale.y = 2;
		y = 0-height*2;
		updateHitbox();
	}
	public function updateNube():Void
	{
		trace(y);
		if (y >= FlxG.height+height) 
		{
			y = 0-height*2;
			velocity.y = 0;
		}
	}
	public function launch():Void
	{
		velocity.y = 300;
	}
	
}