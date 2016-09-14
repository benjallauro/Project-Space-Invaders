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
	private var tituloA:Bool = false;
	override public function create():Void
	{
		super.create();
		titulo = new FlxText(42,25);
		titulo.text = "Space Invaders";
		titulo.scale.x = 2;
		titulo.scale.y = 2;
		titulo.setBorderStyle(FlxTextBorderStyle.SHADOW, 0xFF1abcc9);
		texto = new FlxText();
		texto.x = FlxG.width/2 - 28;
		texto.y = FlxG.height/2;
		texto.text = "Press Enter";
		highscore = new FlxText(0,FlxG.height - 13 );
		highscore.text = "Highscore: " + Reg.highscore;
		nombres = new FlxText(31, 40);
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
	private function splashScreen():Void
	{
		if (auxContSeg < 60 * 4 && splash)
			nombres.alpha += 0.005;
		else if (auxContSeg >= 60 * 4 && splash)
			nombres.alpha -= 0.008;
		if (nombres.alpha == 0 && tituloB == false)
			pasarDeTitulo();
	}
	private function tituloScreen():Void
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
		if (FlxG.keys.justPressed.ENTER)
		{
			destroyThis();
			FlxG.switchState(new PlayState());
		}
			
	}
	private function pasarDeTitulo():Void
	{
		trace("Asda");
		splash = false;
		nombres.visible = false;
		texto.visible = true;
		titulo.visible = true;
		highscore.visible = true;
		tituloB = true;
		tituloA = true;
		auxContSeg = 0;
	}
	private function destroyThis():Void
	{
		texto.destroy();
		titulo.destroy();
		highscore.destroy();
		nombres.destroy();
		
	}
	override public function update(elapsed:Float):Void
	{
		auxContSeg++;
		splashScreen();
		if ((tituloB || FlxG.keys.justPressed.ANY)&&!tituloA)
			pasarDeTitulo();
		else if (tituloA)
			tituloScreen();
		super.update(elapsed);
	}
}
