package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;

class MenuState extends FlxState
{
	private var texto:FlxText;
	private var titulo:FlxText;
	private var auxContSeg:Int = 0;
	override public function create():Void
	{
		super.create();
		titulo = new FlxText(42,25);
		titulo.text = "Space Invaders";
		titulo.scale.x = 2;
		titulo.scale.y = 2;
		texto = new FlxText();
		texto.x = FlxG.width/2 - 28;
		texto.y = FlxG.height/2;
		texto.text = "Press Enter";
		add(titulo);
		add(texto);
	}

	override public function update(elapsed:Float):Void
	{
		auxContSeg++;
		if (auxContSeg == 30 && texto.visible == true) 
			{
				texto.visible = false;
				auxContSeg = 0;
			}
		else if (auxContSeg == 30 && texto.visible == false)
			{
				texto.visible = true;
				auxContSeg = 0;
			}
		super.update(elapsed);
		if (FlxG.keys.justPressed.ENTER)
			FlxG.switchState(new PlayState());
	}
}
