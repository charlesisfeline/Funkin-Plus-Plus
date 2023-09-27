package video;

import hxcodec.flixel.FlxVideo;

class NativeVideo
{
	var video:FlxVideo;
	var finishCallback:Void->Void;

	public function new(vidSrc:String, finishCallback:Void->Void)
	{
		this.finishCallback = finishCallback;

		video = new FlxVideo();
		video.onEndReached.add(onEndReached);
		video.play(Paths.file(vidSrc));
	}

	public function finish()
	{
		video.stop();
		onEndReached();
	}

	function onEndReached()
	{
		video.dispose();

		if (finishCallback != null)
			finishCallback();
	}
}