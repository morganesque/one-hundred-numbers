package com.commonagency
{
	import flash.display.Stage;
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	public class cDisplay extends Object 
	{
		public static function center(obj:*, stg:Stage):void
		{
			obj.x = stg.stageWidth/2;
			obj.y = stg.stageHeight/2;
		}
		
		public static function flipHorizontal(dsp:DisplayObject):void
		{
			var matrix:Matrix = dsp.transform.matrix;
			matrix.a=-1;
			matrix.tx=dsp.width+dsp.x;
			dsp.transform.matrix=matrix;
		}

		public static function flipVertical(dsp:DisplayObject):void
		{
			var matrix:Matrix = dsp.transform.matrix;
			matrix.d=-1;
			matrix.ty=dsp.height+dsp.y;
			dsp.transform.matrix=matrix;
		}
		
		public static function scale(mc:DisplayObject, new_size:Number, type:String)
		{
			var ratio = mc.width/mc.height;
			switch(type)
			{
				case 'width':
					mc.width = new_size;
					mc.height = new_size/ratio;
				break;
				case 'height':
					mc.height = new_size;
					mc.width = ratio * new_size;
				break;
			}
		}
		
		/**
		*	places a display object to the right of a target display object with a spacing of 'offset'. 
		*/
		public static function rightOf(dsp:DisplayObject, target:DisplayObject, offset:Number=5):void
		{
			dsp.x = target.x + target.width + offset;
		}	
		
		/**
		*	places a display object underneath another display object with a spacing of 'offset'.
		*/
		public static function downOf(dsp:DisplayObject, target:DisplayObject, offset:Number=5):void
		{
			dsp.y = target.y + target.height + offset;
		}

		/**
		*	lays out a colum of display objects left to right with a spacing of 'offset'.
		*/
		public static function rightwardCol(array:Array, offset:Number=5)
		{
			var i:int;
			for(i=0; i<array.length; i++)
			{
				if (i > 0) rightOf(array[i], array[(i-1)], offset);
			}
		}
		
		/**
		*	lays out a colum of display objects top to bottom with a spacing of 'offset'.
		*/
		public static function downwardCol(array:Array, offset:Number=5)
		{
			var i:int;
			for(i=0; i<array.length; i++)
			{
				if (i > 0) downOf(array[i], array[(i-1)], offset);
			}
		}
		
		public static function removeAllChildren(container:DisplayObjectContainer):void
		{
		    while (container.numChildren) container.removeChildAt(0);
		}
		
		public static function storeShape(d:DisplayObject):Shape
		{
		    var s = new Shape();
            s.alpha = d.alpha;
            s.height = d.height;
            s.rotation = d.rotation;
            s.scaleX = d.scaleX;
            s.scaleY = d.scaleY;
            s.width = d.width;
            s.x = d.x;
            s.y = d.y;
            return s;
		}
		
		public static function findClicks(s:Stage):void
		{
		    s.addEventListener(MouseEvent.CLICK, function(e:MouseEvent)
		    {
		       trace("cDisplay::findClicks() - ", e.target, e.target.name, e.currentTarget, e.currentTarget.name); 
		    });
		}
		
		/**
		* Takes a DisplayObject and lays it out in a grid depending on the values
		* passed. Assumes you're working within a for loops where you can pass i to
		* denote the number of the item within the array.
		*/
		public static function grid(i:uint, mc:*, cols:uint, spacing:*=null, starting:*=null):void
		{
            var p = returnGrid(i, mc, cols, spacing, starting)
		    mc.x = p.x;
		    mc.y = p.y;
		}
		
        public static function returnGrid(i:uint, mc:*, cols:uint, spacing:*=null, starting:*=null):Point
        {
		    var w = mc.width, h = mc.height, _space:Point, _start:Point;
		    
		    if (spacing == null) _space = new Point(w,h);
		    if (spacing is Number) _space = new Point(spacing+w,spacing+h);
		    if (spacing is Array) _space = new Point(spacing[0]+w,spacing[1]+h);
		    
		    if (starting == null) _start = new Point(0,0);
		    if (starting is Number) _start = new Point(starting,starting);
		    if (starting is Array) _start = new Point(starting[0],starting[1]); 
		    
		    var p = new Point();
		    p.x = _start.x + (i % cols) * _space.x;
            p.y = _start.y + Math.floor(i / cols) * _space.y;         
            return p;
        }
	}
}