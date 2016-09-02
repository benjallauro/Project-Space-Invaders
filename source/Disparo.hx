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
	
	public function new(?X:Float, ?Y:Float, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(5, 10, FlxColor.YELLOW);
		velocity.y = -10;
		y = 80;
	}
	
	public function  GetX():Float
	{
		return x;
	}
	
	public function GetY():Float
	{
		return y;
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