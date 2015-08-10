package com.commonagency
{
	import flash.display.BitmapData; 
	import flash.display.DisplayObject;
	
	public class cMath
	{
		public static function cos(deg:Number):Number
		{
			return Math.cos(deg * Math.PI / 180);
		}
		
		public static function sin(deg:Number):Number
		{
			return Math.sin(deg * Math.PI / 180);
		}		
		
		public static function normalize(value:Number, minimum:Number, maximum:Number):Number
		{
			return (value - minimum) / (maximum - minimum);
		}
		
		public static function interpolate(normValue:Number, minimum:Number, maximum:Number):Number
		{
			return minimum + (maximum - minimum) * normValue;
		}
		
		public static function map(value:Number, min1:Number, max1:Number, min2:Number, max2:Number):Number
		{
			return interpolate( normalize(value, min1, max1), min2, max2);
		}

		public static function sum(a:Array):Number
		{
			var result=0,i:uint=0;
			while (i<a.length)
			{
				result += a[i];
				i++;
			}
			return result;
		}
		
		public static function random(high:Number, low:Number=0):Number
		{
			return low + Math.random() * (high-low);
		}
		
		public static function randArray(a:Array):*
		{
			var i:uint = Math.floor(random(a.length));
			return a[i];
		}
		
		public static function average(a:Array):Number
		{
			var res:Number = ( sum(a) / a.length );
			// trace(a + ' - length: '+a.length+' - ave: '+res);
			return res;
		}

		public static function trimmedMean(a:Array, trim:uint = 10):Number
		{
			a.sort();
			var s:Number = a.length/2 - trim/2;
			var m:Array = a.slice(s, s+trim);
			return average(m);
		}
		
		public static function round(n:Number, r:int=0):Number
		{
			var rv:Number = Math.pow(10,r);
			return Math.round(n * rv)/rv;
		}
	
		
		/**
		* generates an array of length 'len' which consists of numbers between 0 and 1 fluctuating according to the Perlin Noise function.
		*/
		public static function perlinRange(len:uint):Array
		{
			var hi, lo, v:uint = 0;
			var bmd:BitmapData = new BitmapData(len,1,false);
			
			var seed:Number = Math.floor(Math.random() * 10);
			bmd.perlinNoise(len, 1, 6, seed, true, true, 1, false, null);
			
			var values:Array = new Array();
			var a:int;
			for(a=0; a<len; a++)
			{
				v = uint('0x' + bmd.getPixel(a,0).toString(16).substr(0,2));
				if (!hi || v > hi) hi = v;
				if (!lo || v < lo) lo = v;
				values[a] = v;
			}		
			var diff:uint = hi - lo;
			for(a=0; a<len; a++)
			{
				var b:Number = (values[a] - lo)/diff;
				values[a] = b;
			}
			return values;
		}
		
		public static function dist(obj1:*, obj2:*)
		{
			var dx:Number = obj1.x - obj2.x;
			var dy:Number = obj1.y - obj2.y;
			return Math.sqrt((dx*dx) + (dy*dy));
		}
		
		public static function jig(n:Number):Number
		{
			return 0 - random(2*n);
		}
		
		public static function distAng(obj1:*, obj2:*):Object
		{
			var dx:Number = obj1.x - obj2.x;
			var dy:Number = obj1.y - obj2.y;
			var dist:Number = Math.sqrt((dx*dx) + (dy*dy));
			var ang:Number = Math.atan2(dy,dx) * 180/Math.PI;
			return {distance:dist, angle:ang};
		}

		/**
		* Greatest common factor. The greatest number which divides into both.
		*/
        public function gcf(a:int, b:int):int
        {
        	var remainder:int;
        	var factor:Number = 0;
        	while (1){
        		if (b> a){
        		   var swap:int = a;
        		   a = b;
        		   b = swap;
        		}
        		remainder = a % b;
        		a = b;
        		b = remainder
        		if (remainder == 0){
        			factor = a;
        			break;
        		}else if (remainder==1){
        			break;
        		}
        	}
        	return factor;
        }
	}
}