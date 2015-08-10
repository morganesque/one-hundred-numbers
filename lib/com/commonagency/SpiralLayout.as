package com.commonagency
{
	public class SpiralLayout
	{
		var gx = 0;
		var gy = 0;
		
		var dir:Array = new Array('R','U','L','D');
		var d:uint = 0;
		
		var e:uint = 1;
		
		public function SpiralLayout(a:Array, dif:uint)
		{
			var b=0; var c=0; 
			
			for(var i=1; a[i]; i++)
			{				
				if (b == e)
				{
					d++; if (d == dir.length) d=0;
					b=0;
					c++;
				}
				
				if (c == 2)
				{
					e++;
					c=0;
				}
				
				switch(dir[d])
				{
					case 'R': gx += dif; break;
					case 'U': gy -= dif; break;
					case 'L': gx -= dif; break;
					case 'D': gy += dif; break;
				}	
				
				a[i].x = gx;
				a[i].y = gy;				
				
				b++;
			}
		}
	}
}