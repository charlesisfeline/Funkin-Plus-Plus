package;

// optional

#if VIDEOS_ALLOWED
import flixel.*;
import flixel.FlxG;

using StringTools;

class VideoState extends MusicBeatState
{
	public static var seenVideo:Bool = false;

	var video:FlxVideo;

	var videoPath:String = 'videos/kickstarterTrailer.mp4';
	
	override function create()
	{
		super.create();

		seenVideo = true;

		FlxG.save.data.seenVideo = true;
		FlxG.save.flush();

		if (FlxG.sound.music != null)
			FlxG.sound.music.stop();

		video = new FlxVideo(videoPath, finishVid);
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
#end