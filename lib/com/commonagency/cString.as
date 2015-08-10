package com.commonagency
{
	public class cString 
	{	
		public static function split(string:String, delimiter:*, limit:Number = 0x7fffffff):Array
		{
			var bits:Array = string.split(delimiter,limit);
			var newb:Array = new Array();
			for each(var val:String in bits)
			{
				if (val.length > 0)
				{
					newb.push(val);
				}
			}
			return newb;
		}
				
		public static function replace(str:String, oldSubStr:String, newSubStr:String):String {
	        return str.split(oldSubStr).join(newSubStr);
	    }

	    public static function trim(str:String, char:String=' '):String {
	        return trimBack(trimFront(str, char), char);
	    }

	    public static function trimFront(str:String, char:String):String {
	        char = stringToCharacter(char);
	        if (str.charAt(0) == char) {
	            str = trimFront(str.substring(1), char);
	        }
	        return str;
	    }

	    public static function trimBack(str:String, char:String):String {
	        char = stringToCharacter(char);
	        if (str.charAt(str.length - 1) == char) {
	            str = trimBack(str.substring(0, str.length - 1), char);
	        }
	        return str;
	    }

	    public static function stringToCharacter(str:String):String {
	        if (str.length == 1) {
	            return str;
	        }
	        return str.slice(0, 1);
	    }
	
		public static function ucFirst(str:String):String
		{
			var f = str.substr(0,1).toUpperCase();
			var r = str.substr(1, str.length-1);
			return f+r;
		}
		
		public static function levenshteinDistance(s1:String,s2:String):int
        {
            var m:int=s1.length;
            var n:int=s2.length;
            var matrix:Array=new Array();
            var line:Array;
            var i:int;
            var j:int;
            
            for (i=0;i<=m;i++)
            {
                line=new Array();
                for (j=0;j<=n;j++)
                {
                    if (i!=0) line.push(0)
                    else line.push(j);
                }
                line[0]=i
                matrix.push(line);
            }
            var cost:int; 
            for (i=1;i<=m;i++)
            for (j=1;j<=n;j++)
            {
                if (s1.charAt(i-1)==s2.charAt(j-1)) cost=0
                else cost=1;
                matrix[i][j]=Math.min(matrix[i-1][j]+1,matrix[i][j-1]+1,matrix[i-1][j-1]+cost);
            }
            return matrix[m][n]; 
        }
        
        		/**
        *   Turns a Number into a String converting seconds (or milliseconds)
        *   into a more pretty MM:SS kind of time display.
        *   
        *   type: seconds || milliseconds
        */
        public static function secondsToTime(t:Number,type:String):String
        {            
            var seconds:Number;
            if (type == 'milliseconds') seconds = Math.round(t / 1000); 
            if (type == 'seconds') seconds = Math.round(t);
            
            return String(doubleDigit(Math.floor(seconds / 60))+':'+doubleDigit(seconds % 60));
        }
        
        /**
        *   adds a nought to the beginning of a number for display purposes.
        */
        public static function doubleDigit(t:Number):String
        {
            if (String(t).length < 2) return '0'+t;
            else return String(t);
        }
	}
}

