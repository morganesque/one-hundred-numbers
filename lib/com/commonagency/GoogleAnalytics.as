package com.commonagency
{
	import flash.events.EventDispatcher;
	
	import com.google.analytics.AnalyticsTracker; 
	import com.google.analytics.GATracker; 
	import flash.display.DisplayObject;

	public class GoogleAnalytics extends EventDispatcher 
	{
		private static var _instance:GoogleAnalytics;
		private static var _tracker:AnalyticsTracker;

		private static var CODE:String;
	
		public static function get i():GoogleAnalytics
		{
			return initialize();
		}
	
		public static function initialize():GoogleAnalytics
		{
			if (_instance == null){
				_instance = new GoogleAnalytics();
			}
			return _instance;
		}
	
		public function GoogleAnalytics()
		{
			super();
			if( _instance != null ) throw new Error( "Error:GoogleAnalytics already initialised." );
			if( _instance == null ) _instance = this;
		}
	
		public function init(main:DisplayObject, code:String, version:String='AS3', debug:Boolean = false):void
		{
			CODE = code;
			_tracker = new GATracker(main, code, version, debug );
		}
		
		public function track(url:String):void
		{
		    if (!Config.DO_GA) return;
		    
			url = makeSafe(url);
			/*trace('GoogleAnalytics: '+url);*/
			
			// only call if the player is not just being tested in the IDE.
			if (!Config.PLAYING_IN_IDE) _tracker.trackPageview(url); 
		}
		
		private function makeSafe(s:String):String
		{
			var r:RegExp = / /g;
			
			s = s.toLowerCase();
			s = s.replace(r,'_');
			return '/'+s;
		}
	}
}