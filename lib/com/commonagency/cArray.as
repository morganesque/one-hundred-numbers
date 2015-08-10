package com.commonagency
{
	dynamic public class cArray extends Array 
	{	
		public function cArray(... optionalArgs)
		{
			for each (var value:* in optionalArgs)
			{
				super.push(value);
			}
		}
			
		public function shuffle(startIndex:int = 0, endIndex:int = 0):Array
		{
			if(endIndex == 0) endIndex = this.length-1;
			
			for (var i:int = endIndex; i>startIndex; i--) 
			{
				var randomNumber:int = Math.floor(Math.random()*endIndex)+startIndex;
				var tmp:* = this[i];
				this[i] = this[randomNumber];
				this[randomNumber] = tmp;
			}
			return this;
		}

		/*
		public static function randomise():void
		{
			var newArray:Array = new Array();
			while(this.length > 0)
			{ 
				var tmp = this.splice(Math.floor(Math.random()*this.length), 1);
				newArray.push(tmp[0]);
			}
			return newArray;
		}
		*/
	}
}

