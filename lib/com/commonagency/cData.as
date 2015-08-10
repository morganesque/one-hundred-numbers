package com.commonagency
{
	import flash.net.URLLoader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	
	public class cData extends cAssetLoader 
	{			
		/**
		*	OVERRIDE FUNCTIONS - - - - - - - - - - - - - - - - - - - - - - - - 
		*/
		
		override public function getLoaderAsset():*
		{
			return _loader.data;
		}
		
		override public function getNewLoader():*
		{
			var l = new URLLoader(); 
			l.addEventListener(Event.COMPLETE, onAssetLoaded);
			l.addEventListener(IOErrorEvent.IO_ERROR, IOErrorFunc);
			l.addEventListener(ProgressEvent.PROGRESS, onProgress);
			return l;
		}
		
		/**
		*	SINGLTON FUNCTIONS - - - - - - - - - - - - - - - - - - - - - - - - 
		*/
		
		private static var _instance:cData;
		
		public static function get i():cData
		{
			return initialize();
		}
		
		public static function initialize():cData
		{
			if (_instance == null){
				_instance = new cData();
			}
			return _instance;
		}
		
		public function cData()
		{
			super();
			if( _instance != null ) throw new Error( "Error:cAssetLoader already initialised." );
			if( _instance == null ) _instance = this;
		}
	}
}