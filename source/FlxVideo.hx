package;

#if VIDEOS_ALLOWED
class FlxVideo
{
	var backend:VideoBackend;

	/**
	 * Doesn't actually interact with Flixel shit, only just a pleasant to use class    
	 */
	public function new(vidSrc:String, finishCallback:Void->Void)
	{
		backend = new VideoBackend(vidSrc, finishCallback);
	}

	public function finish()
	{
		backend.finish();
	}
}

@:noCompletion private typedef VideoBackend = #if html5 video.HTML5Video #else video.NativeVideo #end;
#end