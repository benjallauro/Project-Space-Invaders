package;

import flixel.FlxG;
class Reg
{	
	static public var heightEnemigos:Int = 10;
	static public var widhtEnemigos:Int = 10;
	static public var espacioEntreEnem:Float = heightEnemigos/2;
	static public var cantEnemigosPorLinea:Int = 7;
	static public var highscore:Int = 0;
	static public var score:Int = 0;
	static public var cantTotalEnemigos:Int = cantEnemigosPorLinea * 3;
	static public var cantEnemigosDestruidos:Int = 0;
	static public var juegoGanado:Bool = false;
	static public function checkHighscore():Bool
	{
		if (score > highscore)
			return true;
		else 
			return false;
	}
	
}