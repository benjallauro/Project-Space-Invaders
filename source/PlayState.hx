package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;

class PlayState extends FlxState
{
	override public function create():Void
	{
		super.create();
		var zazz:Nave = new Nave();
		add(zazz);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
