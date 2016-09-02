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
	private var tipoDisparo:String;
	private var activa:Bool;
	public function new(_tipoDisparo:String,?X:Float, ?Y:Float, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(5, 10, FlxColor.YELLOW);
		activa = false;
		if (_tipoDisparo == "aliado" || _tipoDisparo == "enemigo")
			tipoDisparo = _tipoDisparo;
		else 
			trace("El tipoDisparo esta mal");	
		visible = false;		
	}	
	public function  GetX():Float
	{
		return x;
	}	
	public function GetY():Float
	{
		return y;
	}
	public function getActiva():Bool
	{
		return activa;
	}
	public function getTipoDisparo():String
	{
		return tipoDisparo;
	}
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		if (y <= 0)
			resetear();
	}
	public function disparar(_x:Float, _y:Float)
	{
		if (activa == false) 
		{
			activa = true;
			x = _x;
			y = _y;
			visible = true;
			switch(tipoDisparo)
			{
				case "aliado":
					velocity.y = -70;
				case "enemigo":
					velocity.y = 70;
			}
		}
	}
	private function resetear()
	{
		activa = false;
		velocity.y = 0;
		x = 10;
		y = 10;
		visible = false;
	}	
}