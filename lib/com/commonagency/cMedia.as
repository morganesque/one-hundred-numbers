package com.commonagency
{
	import flash.net.URLRequest;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;

	public class cMedia extends Loader 
	{
		public var data:Object = new Object;

		var _ratio:Number;
		var _path:String;
		var params:Object;
		var onLoadFunction:Function;		

		private var _paramSet:Boolean = false;

		function cMedia(img:String,p_params:Object=null,loadFunc:Function=null) 
		{			
			_path = img;
			params = p_params;
			onLoadFunction = loadFunc;					
            
			contentLoaderInfo.addEventListener(Event.COMPLETE, setDimensions);
			contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, IOErrorFunc);
			contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress);
            
			if (loadFunc !== null) contentLoaderInfo.addEventListener(Event.COMPLETE, loadFunc);

            load(new URLRequest(img));						
		}
		
		private function setDimensions(ev:Event):void
		{			
			_ratio = width / height;
			if (params !== null)
			{
				if (params.width && params.height == undefined) params.height = params.width / _ratio;
				if (params.height && params.width == undefined) params.width = params.height * _ratio;
				for (var i in params) 
				{
					if (hasOwnProperty(i)) // if it's a loader property apply it otherwise it must be data.
					{
						this[i] = params[i];	
					} else {
						data[i] = params[i];
					}
				}
			}
			_paramSet = true;
		}
		
		public function changeWidth(nw:int, mar:Boolean=true) // nw = new width // mar = maintain aspect _ratio.
		{
			if (_paramSet)
			{
				width = nw;
				if (mar) height = getRatioHeight(nw);
			}
			else Logger.debug("Image::changeWidth() - can\'t change width before the image has loaded");
		}
		
		public function changeHeight(nh:int, mar:Boolean=true) // nh = new height // mar = maintain aspect _ratio.
		{
			if (_paramSet)
			{
				height = nh;
				if (mar) width = getRatioWidth(nh);
			}
			else Logger.debug("Image::changeHeight() - can\'t change height before the image has loaded");
		}
		
		public function getRatioHeight(nw:int)
		{
			return nw / _ratio;
		}
		
		public function getRatioWidth(nh:int)
		{
			return nh * _ratio;
		}
		
		public function IOErrorFunc(e:IOErrorEvent)
		{
			Logger.debug("Image::IOErrorFunc() - tried to load file - "+_path);
		}
		
		public function get path():String
		{
			return _path;
		}
		
		private function onProgress(e:ProgressEvent):void
		{
			dispatchEvent(e);
		}
	}
}