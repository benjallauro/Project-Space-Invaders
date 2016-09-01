package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;

class Enemigos extends FlxSprite
{
	private var auxContSeg:Int = 0;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(16, 16, FlxColor.GREEN);
	}
	public function updateEnemigos()
	{
		mover();
	}
	private function mover()
	{
		auxContSeg++;	
		if (auxContSeg == 60) 
		{
			y += 5;
			auxContSeg = 0;
		}	
	}
}