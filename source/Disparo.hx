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
		activa = false;
		if (_tipoDisparo == "aliado" || _tipoDisparo == "enemigo")
			tipoDisparo = _tipoDisparo;
		else 
			trace("El tipoDisparo esta mal");	
			
			
		if (_tipoDisparo == "aliado")
			loadGraphic(AssetPaths.BalasNave__png);
		else if ( _tipoDisparo == "enemigo")
			loadGraphic(AssetPaths.BalasEnemigos__png);
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
	public function updateDisparos(_nave:Nave, _arrayEnemigos:Array<Enemigos>):Void 
	{
		if (y <= 0 || y >= FlxG.height)
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
					velocity.y = -120;
				case "enemigo":
					velocity.y = 70;
			}
		}
	}
	public function resetear():Void
	{
		activa = false;
		velocity.y = 0;
		x = -10;
		y = -10;
		visible = false;
	}	
}