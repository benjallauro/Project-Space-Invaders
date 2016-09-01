package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.FlxG;
/**
 * ...
 * @author ...
 */
class Disparo extends FlxSprite
{	
public function new(?X:Float = 0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		super.makeGraphic(5, 10, FlxColor.WHITE);
		velocity.y = -50;
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		if (y < 0)
		{
			destroy();
		}
	}
}