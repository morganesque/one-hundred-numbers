package com.commonagency
{	
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.AsyncErrorEvent;
	import flash.media.Video;
	
	public class cVideo extends Video
	{		
        private var _connection:NetConnection;
        var _stream:NetStream;

		public function cVideo(width:int = 320, height:int = 240, url:String = null)
		{
			super(width, height);
			
            _connection = new NetConnection();
            _connection.addEventListener(NetStatusEvent.NET_STATUS, _connection_netStatusHandler);
            _connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
            _connection.connect(null);

            _stream = new NetStream(_connection);
            _stream.addEventListener(NetStatusEvent.NET_STATUS, _stream_netStatusHandler);
            _stream.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);

            attachNetStream(_stream);
			
			if (url !== null) playVideo(url);
		}	
        
        function changeVideo(videoURL:String)
        {
            _stream.close();
            _stream.play(videoURL);
        }
		
        function playVideo(videoURL:String)
        {
            _stream.play(videoURL);
        }		

        function _connection_netStatusHandler(event:NetStatusEvent)
        {
			Logger.debug("cVideo::_connection_netStatusHandler() - netstatus-_connection -- code: "+event.info.code+" -- level:"+event.info.level);
        }
        
		function _stream_netStatusHandler(event:NetStatusEvent)
        {
			Logger.debug("cVideo::_stream_netStatusHandler() - netstatus-_stream -- code: "+event.info.code+" -- level: "+event.info.level);
        }		

        function securityErrorHandler(event:SecurityErrorEvent)
        {
        }

        function asyncErrorHandler(event:AsyncErrorEvent)
        {
        }
	}
}