package com.commonagency
{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	public class LoadingWheel extends Sprite
	{
		private var bith:int = 10;
		private var bitw:int = 5;
		private var num:int = 48;
		
		private var wheel:Sprite = new Sprite();
		
		public function LoadingWheel(size:int = 50)
		{		
			for (var i:int = 0; i<num; i++)
			{				
				var s:Sprite = new Sprite();
				s.graphics.beginFill(0X000000);
				s.graphics.drawRect(-bitw/2,bith*10,bitw,bith);
				s.graphics.endFill();
				s.rotation = (360/num) * i;
				s.alpha = (0.5/num) * i;
				wheel.addChild(s);
			}
			addChild(wheel);
			
			var t:Timer = new Timer(50);
			t.addEventListener(TimerEvent.TIMER, updateLoading);
			t.start();			
			
			blendMode = BlendMode.INVERT;
			
			width = size;
			height = size;			
		}
		
		public function updateLoading(t:TimerEvent):void
		{
			// if (num) { trace('got here'); num = 0 }
			wheel.rotation += (360/num);
		}
	}
}