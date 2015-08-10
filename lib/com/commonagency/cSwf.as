package com.commonagency
{
	import flash.events.Event;
	import flash.display.Loader;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.display.Bitmap;

	public class cSwf extends cAssetLoader 
	{		
		/**
		*	OVERRIDE FUNCTIONS - - - - - - - - - - - - - - - - - - - - - - - - 
		*/
		
		override public function getNewLoader():*
		{
			var l = new Loader();
			l.contentLoaderInfo.addEventListener(Event.COMPLETE, onAssetLoaded);
			l.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, IOErrorFunc);
			l.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress);
			return l;
		}

		override public function getLoaderAsset():*
		{
			return _loader;
		}

		override public function returnAsset(asset:*):*
		{
			return asset;
		}
		
		override public function get(url:String, loadFunc:Function):void
		{	
			_assets[url] = null;
			
			if (_loading == '') 
			{
				_queue_total = 1;
				dispatchEvent(new Event(Event.INIT));
				load(url);
				/*_loader.addEventListener(Event.COMPLETE, onLoadComplete);*/
			} else {
				queue(url);
			}
			
			if (!_load_queue[url]) _load_queue[url] = [loadFunc];
			else _load_queue[url].push(loadFunc);
		}

		/**
		*	SINGLTON FUNCTIONS - - - - - - - - - - - - - - - - - - - - - - - - 
		*/
		
		private static var _instance:cSwf;
	
		public static function get i():cSwf
		{
			return initialize();
		}
	
		public static function initialize():cSwf
		{
			if (_instance == null){
				_instance = new cSwf();
			}
			return _instance;
		}
	
		public function cSwf()
		{
			super();
			if( _instance != null ) throw new Error( "Error:cSwf already initialised." );
			if( _instance == null ) _instance = this;
		}
	
	}
}