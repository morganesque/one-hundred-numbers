package com.commonagency
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	
	public class PlaceImage extends Image
	{
		var dragging:Boolean = false;
		var mox:int;
		
		public function PlaceImage(s:String, o:Object=null, f:Function=null)
		{
			super(s,o,f);
			addEventListener(MouseEvent.MOUSE_DOWN, onGrab);
		}
		
		function onGrab(e)
		{
			dragging = true;
			startDrag();
			removeEventListener(Event.ENTER_FRAME, rotateMe);
			stage.addEventListener(MouseEvent.MOUSE_UP, onChuck);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKey);
		}
		
		function onChuck(e)
		{
			dragging = false;
			stopDrag();
			stage.removeEventListener(MouseEvent.MOUSE_UP, onChuck);
			trace(e.target.parent);
			trace('<image x="'+e.target.parent.x+'" y="'+e.target.parent.y+'">'+e.target.contentLoaderInfo.url.substr(160)+'</image>');
		}		
		
		function onKey(e)
		{
			trace(e.keyCode);
			
			stopDrag();
			stage.removeEventListener(MouseEvent.MOUSE_UP, onChuck);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKey);
			stage.addEventListener(KeyboardEvent.KEY_UP, upKey);
			mox = stage.mouseX;
			
			if (e.keyCode == 32) addEventListener(Event.ENTER_FRAME, rotateMe);
		}
		
		function upKey(e)
		{
			removeEventListener(Event.ENTER_FRAME, rotateMe);
		}
		
		function rotateMe(e)
		{
			rotation += stage.mouseX - mox;
			mox = stage.mouseX;
		}
		
	}
}