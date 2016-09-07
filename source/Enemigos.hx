package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;

class Enemigos extends FlxSprite
{
	private var auxContSeg:Int = 0;
	private var puedeDisparar:Bool;
	private var direccion:String;
	private var decender:Bool = false;
	public function new(_puedeDisparar:Bool,?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		puedeDisparar = _puedeDisparar;
		direccion = "derecha";
		if (puedeDisparar)
			makeGraphic(Reg.heightEnemigos, Reg.widhtEnemigos, FlxColor.BLUE);
		else
			makeGraphic(Reg.heightEnemigos, Reg.widhtEnemigos, FlxColor.GREEN);
	}
	public function updateEnemigos(_arrayEnemigos:Array<Enemigos>)
	{
		checkPuedeDisparar(_arrayEnemigos);
		mover();
	}
	public function mover()
	{
		if (!decender) 
		{
			if (direccion == "derecha")
			x += 10;
			else if (direccion == "izquierda")
			x -= 10;	
		}
		else
		{
			y += 10;
			decender = false;
		}	
	}
	private function checkPuedeDisparar(_arrayEnemigos:Array<Enemigos>):Void
	{
		for (i in 0..._arrayEnemigos.length) 
		{
			if (y + Reg.heightEnemigos + Reg.espacioEntreEnem == _arrayEnemigos[i].y && x == _arrayEnemigos[i].x)
				puedeDisparar = false;
			else
				puedeDisparar = true;
		}
	}
	public function checkDireccion():Bool
	{
		if (x + Reg.widhtEnemigos >= FlxG.width || x <= 0)
			return true;
		else
			return false;
	}
	public function cambiarDireccion():Void
	{
		if (!decender)
			decender = true;
		if (direccion == "derecha")
			direccion = "izquierda";
		else if (direccion == "izquierda")
			direccion = "derecha";
	}
	public function setPuedeDisparar(_puedeDisparar:Bool):Void
	{
		puedeDisparar = _puedeDisparar;
	}
	public function getPuedeDisparar():Bool
	{
		return puedeDisparar;
	}
	public function destruir():Void
	{
		trace("enemigo daniado");
		destroy();
	}
}