package com.commonagency
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	
	public class cCentered extends Sprite
	{	
		public var media:cImage;
		var onLoad:Function;
		
		public function cCentered(med:String, p:Object=null, loadFunc:Function=null)
		{
			media = new cImage(med,p,cOnLoad)
			media.addEventListener(ProgressEvent.PROGRESS, onProgress);
			onLoad = loadFunc;
		}
		
		private function cOnLoad(e:Event):void
		{
			if (onLoad !== null) onLoad(e);
			media.x = - media.width/2;
			media.y = - media.height/2;
			addChild(media);
		}
		
		private function onProgress(e:ProgressEvent):void
		{
			dispatchEvent(e);
		}
		
		public function setWidth(n:Number):void
		{
			media.changeWidth(n);
			media.x = - media.width/2;
			media.y = - media.height/2;
		}
	}
}