package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
/*
 * Problema con static en class Reg 
 * 
 */
class PlayState extends FlxState
{
	
	var arrayEnemigos:Array<Enemigos>;	
	public function crearEnemigos():Void
	{
		arrayEnemigos = new Array();
		arrayEnemigos.push(new Enemigos(10, 10));
		for (i in 0...5) 
		{
			arrayEnemigos.push(new Enemigos(arrayEnemigos[arrayEnemigos.length - 1].x + arrayEnemigos[arrayEnemigos.length - 1].width + arrayEnemigos[arrayEnemigos.length - 1].width / 2 , 10));
		}
		arrayEnemigos.push(new Enemigos(10, arrayEnemigos[0].height*2 ));
		for (i in 0...5) 
		{
			arrayEnemigos.push(new Enemigos(arrayEnemigos[arrayEnemigos.length - 1].x + arrayEnemigos[arrayEnemigos.length - 1].width + arrayEnemigos[arrayEnemigos.length - 1].width / 2 , arrayEnemigos[0].height*2));
		}
		for (i in 0...arrayEnemigos.length) 
		{
			add(arrayEnemigos[i]);
		}	
		
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
		for (i in 0...arrayEnemigos.length) 
		{
			arrayEnemigos[i].updateEnemigos();
		}	
		
		
	}
}
