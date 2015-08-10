package com.commonagency
{
	public class Currency
	{	
		public static function format(num:Number, pound:Boolean=true):String
		{
			var intNum = Math.floor(num).toString()
			var decNum = (Math.round((num - Math.floor(num))*100)/100).toString()
			//integer
			var intNumStr;
			if (intNum.length> 3){
				var start = intNum.length % 3
				if (start) intNumStr=intNum.substr(0,start)+","
				else intNumStr=""
				for (var i=start; i<intNum.length-3; i+=3) intNumStr += intNum.substr(i,3) + ","
				intNumStr += intNum.substr(-3,3)
			}else{
				intNumStr = intNum
			}
			//decimal
			while (decNum.length <4) decNum += "0"
			decNum = decNum.substr(-2,2)
			//completed
			if (pound) return "£" + intNumStr +"."+ decNum;
				  else return intNumStr +"."+ decNum;
		}
	}
}

