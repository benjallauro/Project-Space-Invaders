package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.FlxG;

/**
 * ...
 * @author ...
 */
class Escudo extends FlxSprite
{
	var vida:Int = 6;
	private var subeYbaja:Bool = true;
	private var auxContSeg:Int = 0;
	public function new(X:Float=0, Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.Escudo__png);
	}
	public function daniar()
	{
		trace("Escudo daniado");
		vida--;
		if (vida == 4)
			loadGraphic(AssetPaths.EscudoDaniado__png);
		else if (vida == 2)
			loadGraphic(AssetPaths.EscudoDaniado2__png);
		else if (vida <= 0)
		destruirEscudo();
	}
	public function destruirEscudo()
	{
		trace("Escudo destruido");
		destroy();
	}
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		auxContSeg++;
		if (subeYbaja && auxContSeg == 45)
		{
			y -= 3;
			subeYbaja = false;
			auxContSeg = 0;
		}
		else if (!subeYbaja && auxContSeg == 45)
		{
			y += 3;
			subeYbaja = true;
			auxContSeg = 0;
		}
	}
	
}