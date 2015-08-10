package com.commonagency
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import com.greensock.TweenMax;
	import com.greensock.easing.*;
	
	public class cButton 
	{
		public static function make(mc:MovieClip, clickFunc:Function):void
		{
		    mc.addEventListener(MouseEvent.CLICK, clickFunc);
		    mc.addEventListener(MouseEvent.ROLL_OVER, onButtonOver);
            mc.addEventListener(MouseEvent.ROLL_OUT, onButtonOut);  
            mc.buttonMode = true;      
		}
		
		public static function onButtonOver(e:MouseEvent):void
		{
	        TweenMax.to(e.currentTarget, 0.5, {colorMatrixFilter:{brightness:1.5}, ease:Quint.easeOut});
		}
		
		public static function onButtonOut(e:MouseEvent):void
		{
		    TweenMax.to(e.currentTarget, 0.5, {delay:0.2, colorMatrixFilter:{brightness:1}, ease:Quint.easeOut});
		}
	}
}