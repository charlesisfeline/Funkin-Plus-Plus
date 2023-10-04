package video;

#if VIDEOS_ALLOWED
import flixel.FlxG;
import openfl.events.NetStatusEvent;
import openfl.media.Video;
import openfl.net.NetConnection;
import openfl.net.NetStream;

class HTML5Video
{
	var video:Video;
	var netStream:NetStream;
	var finishCallback:Void->Void;

	public function new(vidSrc:String, finishCallback:Void->Void)
	{
		this.finishCallback = finishCallback;

		video = new Video();
		video.x = 0;
		video.y = 0;

		FlxG.addChildBelowMouse(video);

		var netConnection = new NetConnection();
		netConnection.connect(null);

		netStream = new NetStream(netConnection);
		netStream.client = {onMetaData: client_onMetaData};
		netConnection.addEventListener(NetStatusEvent.NET_STATUS, netConnection_onNetStatus);
		netStream.play(Paths.file(vidSrc));
	}

	public function finish()
	{
		netStream.dispose();
		FlxG.removeChild(video);

		if (finishCallback != null)
			finishCallback();
	}

	function client_onMetaData(metaData:Dynamic)
	{
		video.attachNetStream(netStream);

		video.width = FlxG.width;
		video.height = FlxG.height;
	}

	function netConnection_onNetStatus(event:NetStatusEvent):Void
	{
		if (event.info.code == 'NetStream.Play.Complete')
			finish();
	}
}
#end