package com.commonagency
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class cMover extends Sprite
	{
		var dx:Number;
		var dy:Number;
		public var VEL:Number = 2;
		
		public function cMover()
		{
			addEventListener(Event.ENTER_FRAME, moveLoop);
			dx = x;
			dy = y;
		}
		
		function moveLoop(e)
		{
			var vx = dx - x;
			x += vx/VEL;
			
			var vy = dy - y;
			y += vy/VEL;
		}
		
		public function setX(px:Number)
		{
			dx = px;
		}
		
		public function setY(py:Number)
		{
			dy = py;
		}
		
		public function setXY(px:Number, py:Number)
		{
			dx = px;
			dy = py;
		}
	}
}