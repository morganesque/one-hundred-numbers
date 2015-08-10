package com.commonagency
{
	import flash.events.Event;
	import flash.display.Loader;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.display.Bitmap;

	public class cImage extends cAssetLoader 
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
			return new Bitmap(asset.content.bitmapData.clone());
		}

		/**
		*	SINGLTON FUNCTIONS - - - - - - - - - - - - - - - - - - - - - - - - 
		*/
		
		private static var _instance:cImage;
	
		public static function get i():cImage
		{
			return initialize();
		}
	
		public static function initialize():cImage
		{
			if (_instance == null){
				_instance = new cImage();
			}
			return _instance;
		}
	
		public function cImage()
		{
			super();
			if( _instance != null ) throw new Error( "Error:cImage already initialised." );
			if( _instance == null ) _instance = this;
		}
	
	}
}