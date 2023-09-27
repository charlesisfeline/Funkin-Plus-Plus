package;

import flixel.FlxG;
class VideoState extends MusicBeatState
{
	public static var seenVideo:Bool = false;

	var video:FlxVideo;

	override function create()
	{
		super.create();

		seenVideo = true;

		FlxG.save.data.seenVideo = true;
		FlxG.save.flush();

		if (FlxG.sound.music != null)
			FlxG.sound.music.stop();

		video = new FlxVideo('music/kickstarterTrailer.mp4', finishVid);
	}

	override function update(elapsed:Float)
	{
		if (controls.ACCEPT)
			video.finish();

		super.update(elapsed);
	}

	function finishVid():Void
	{
		TitleState.initialized = false;
		FlxG.switchState(new TitleState());
	}
}
