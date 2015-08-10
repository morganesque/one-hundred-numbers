package com.commonagency
{
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class cTimer extends Timer
	{
		private var
		 		_func:Function,
				_repeat:int,
				_rh:Number, // random high
				_rl:Number; // random low
		
		var isRandom:Boolean = false;
		
		/**
		*	a updated Timer which allows you to specify time in seconds
		*	and also calls the function imediately before starting the timer
		*	then calls a function every x seconds from them on.
		*	
		*	You can also tell it to only call the function once (wonc)
		*	which means it isn't called straight away but waits for the
		*	timer.
		*/
		public function cTimer(seconds:Number, timeFunc:Function, repeat:int=0)
		{  		
			_func = timeFunc;
			_repeat = repeat;
			var m = seconds * 1000;
						
			super(m,repeat);
			addEventListener(TimerEvent.TIMER, onTime);
			start();
			
			if (_repeat != 1) _func();
		}
		
		function onTime(te:TimerEvent)
		{
			_func();
			if (isRandom) delay = Math.round(1000 * (_rl + Math.random() * (_rh-_rl)));
			if (_repeat == 1) 
			{
			    removeEventListener(TimerEvent.TIMER, onTime);
			    reset();
		    }
		}
		
		public function makeRandom(high:Number, low:Number=0):void
		{
			_rh = high;
			_rl = low;
			isRandom = true;
		}
		
		public function runAgain()
		{
			start();
		}
	}
}