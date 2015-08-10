package com.commonagency
{
	import flash.display.Sprite;	
	import flash.net.URLRequest;
	import flash.display.Loader;
	import flash.events.HTTPStatusEvent;
	import common.cLoadingWheel;
	import flash.events.Event;
	import flash.events.IOErrorEvent;

	public class Image extends Sprite 
	{
		public var loader:Loader = new Loader();
		public var data:Object = new Object;
		public var ratio:Number;
		public var filename:String;		
		
		var timer:cLoadingWheel;
		var params:Object;
		var onLoadFunction:Function;
		var paramSet:Boolean = false;
		
		function Image(img:String,p_params:Object=null,loadFunc:Function=null) 
		{		
			filename = Config.PATH+'images/'+img;			
			if (filename.indexOf('//') >= 0) throw new Error("You've got a double slash // in your filename - Flash no likee!!" );
			
			params = p_params;
			onLoadFunction = loadFunc;					
            
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, setDimensions);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, IOErrorFunc);
			loader.contentLoaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS, onHttpStatus);
            
			if (loadFunc !== null) loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadFunc);
			
			timer = new cLoadingWheel();
			addChild(timer);
			
			var url = new URLRequest(filename);
            loader.load(url);
		}
		
		private function setDimensions(ev:Event):void
		{			
			/*Logger.debug("Image::setDimensions() - loaded: "+filename);*/
			timer.visible = false;						
			addChildAt(loader,0);				
			ratio = loader.width / loader.height;
						
			if (params !== null)
			{
				if (params.width && params.height == undefined) params.height = params.width / ratio;
				if (params.height && params.width == undefined) params.width = params.height * ratio;
				for (var i in params) 
				{
					if (loader.hasOwnProperty(i)) // if it's a loader property apply it otherwise it must be data.
					{
						loader[i] = params[i];	
					} else {
						data[i] = params[i];
					}
				}
			}

			paramSet = true;
					
			if (data.centered)
			{
				x -= width/2;
				y -= height/2;
			}
		}
		
		public function drawBoundary():void
		{
			if (paramSet)
			{
				graphics.lineStyle(1, 0xFF0000);
				graphics.drawRect(0,0,loader.width,loader.height);
			} else throw new Error('can\'t draw boundary before image has loaded.');
		}
		
		public function changeWidth(nw:int, mar:Boolean=true) // nw = new width // mar = maintain aspect ratio.
		{
			if (paramSet)
			{
				loader.width = nw;
				if (mar) loader.height = getRatioHeight(nw);
			}
			else trace('can\'t change width before the image has loaded');
		}
		
		public function changeHeight(nh:int, mar:Boolean=true) // nh = new height // mar = maintain aspect ratio.
		{
			if (paramSet)
			{
				loader.height = nh;
				if (mar) loader.width = getRatioWidth(nh);
			} else trace('can\'t change height before the image has loaded');
		}
		
		public function getRatioHeight(nw:int)
		{
			return nw / ratio;
		}
		
		public function getRatioWidth(nh:int)
		{
			return nh * ratio;
		}
		
		public function IOErrorFunc(e:IOErrorEvent)
		{
			throw new Error('IO Error: tried to load file - '+filename);
		}
		
		public function onHttpStatus(e:HTTPStatusEvent):void
		{
			/*Logger.debug("Image::onHttpStatus() - "+e);*/
		}
	}
}