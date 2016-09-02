package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;

class Enemigos extends FlxSprite
{
	private var auxContSeg:Int = 0;
	private var puedeDisparar:Bool;
	public function new(_puedeDisparar:Bool,?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		puedeDisparar = _puedeDisparar;
		if (puedeDisparar)
			makeGraphic(16, 16, FlxColor.BLUE);
		else
			makeGraphic(16, 16, FlxColor.GREEN);
	}
	public function updateEnemigos()
	{
		mover();
			
	}
	private function mover()
	{
		//auxContSeg++;	
		//if (auxContSeg == 60) 
		//{
			y += 1;
			//auxContSeg = 0;
		//}	
	}
	public function setPuedeDisparar(_puedeDisparar:Bool):Void
	{
		puedeDisparar = _puedeDisparar;
	}
	public function getPuedeDisparar():Bool
	{
		return puedeDisparar;
	}
}