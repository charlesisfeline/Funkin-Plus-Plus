package unused;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class OutdatedSubState extends MusicBeatState
{
	var txt:FlxText;
	var bg:FlxSprite;

	override function create()
	{
		super.create();

		bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		add(bg);

		txt = new FlxText(0, 0, FlxG.width, "HEY! Please note that this engine is unfinished!\nPress Space or ESCAPE to ignore this!!", 32);
		txt.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, CENTER);
		txt.screenCenter();
		add(txt);
	}

	override function update(elapsed:Float)
	{
		if (controls.ACCEPT)
			FlxG.openURL("https://ninja-muffin24.itch.io/funkin");
		if (controls.BACK)
			FlxG.switchState(new states.MainMenuState());

		super.update(elapsed);
	}
}
