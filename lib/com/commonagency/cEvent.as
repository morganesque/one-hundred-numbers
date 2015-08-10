package com.commonagency
{
	import flash.events.Event;
	
	public class cEvent extends Event 
	{	
		var _data:Object;
		
		public function cEvent(type:String, bubbles:Boolean, d:Object=null)
		{
			super(type, bubbles);
			_data = d;
		}
				
		public function get data():Object
		{
			return _data;
		}
		
		public function addData(d:Object):void
		{
			for(var k in d)
			{
				data[k] = d[k];
			}
		}
	}
}

