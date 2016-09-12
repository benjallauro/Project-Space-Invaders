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
	private var highscore:FlxText;
	private var nombres:FlxText;
	private var auxContSeg:Int = 0;
	private var splash:Bool = true;
	private var tituloB:Bool = false;
	override public function create():Void
	{
		super.create();
		titulo = new FlxText(42,25);
		titulo.text = "Space Invaders";
		titulo.scale.x = 2;
		titulo.scale.y = 2;
		titulo.setBorderStyle(FlxTextBorderStyle.SHADOW, 0xFF07389f);
		texto = new FlxText();
		texto.x = FlxG.width/2 - 28;
		texto.y = FlxG.height/2;
		texto.text = "Press Enter";
		highscore = new FlxText(0,FlxG.height - 13 );
		highscore.text = "Highscore: " + Reg.highscore;
		nombres = new FlxText(30, 40);
		nombres.text = "Desarrollado por:\n Benjamin llauro\n             y\nJoaquin Liberatore";
		titulo.visible = false;
		texto.visible = false;
		highscore.visible = false;
		nombres.alpha = 0;
		add(nombres);
		add(titulo);
		add(texto);
		add(highscore);
	}

	override public function update(elapsed:Float):Void
	{
		auxContSeg++;
		if (auxContSeg < 60 * 4 && splash)
			nombres.alpha += 0.005;
		else if (auxContSeg >= 60 * 4 && splash)
			nombres.alpha -= 0.008;
		
		if (nombres.alpha == 0 && tituloB == false)
			{
				splash = false;
				texto.visible = true;
				titulo.visible = true;
				highscore.visible = true;
				tituloB = true;
				auxContSeg = 0;
			}
		if (tituloB)
		{
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
		}
		super.update(elapsed);
		if (FlxG.keys.justPressed.ENTER)
			FlxG.switchState(new PlayState());
	}
}
