package com.commonagency
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	
	public class cLink extends Sprite 
	{
		public var href:String;
		
		public function cLink(xp:XML)
		{
			href = xp.@href;
			buttonMode = true;
			
			alpha = Config.LINK_ALPHA;
			
			graphics.beginFill(0xFF0000);
			graphics.drawRect(0, 0, xp.@width, xp.@height);
			graphics.endFill();
			
			x = xp.@x;
			y = xp.@y;
			
			addEventListener(MouseEvent.CLICK, onMouseClick)
		}
		
		private function onMouseClick(e:MouseEvent):void
		{
			navigateToURL(new URLRequest(href), '_blank');
		}
	}
}