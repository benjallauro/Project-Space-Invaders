package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;

class PlayState extends FlxState
{
	var arrayEnemigos:Array<Enemigos>;
	
	
	public function crearEnemigos():Void
	{
		arrayEnemigos = new Array();
		arrayEnemigos.push(new Enemigos(10,10));
		arrayEnemigos.push(new Enemigos(30, 30));
		add(arrayEnemigos[0]);
		add(arrayEnemigos[1]);
		
	}
	
	override public function create():Void
	{
		super.create();
		
		crearEnemigos();
		
		var zazz:Nave = new Nave();
		add(zazz);
	
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		
	}
}
