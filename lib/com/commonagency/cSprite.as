package com.commonagency
{
	import flash.display.Sprite;
	import flash.events.Event;

	import gs.TweenMax;
	import gs.easing.*;
	import flash.utils.Dictionary;
		
	public class cSprite extends Sprite
	{
		public var data:Object = new Object();
		private var points:Dictionary = new Dictionary();
				
		public function cSprite()
		{}
		
		public function addPoint(p:String, point:Object)
		{			
			points[p] = point;
		}
		
		public function move(p:String, t:Number=1)
		{
			TweenMax.killTweensOf(this, true);
			TweenMax.to(this, t, points[p]);
		}
		
		/*
		*	These functions were used to generate standard inPoint and outPoints based on objects or XML
		*	I've replaced them now in order to try and make things more flexible.
		*	
		
		public function initWithObjects(oin:Object, oot:Object, startOut:Boolean=true)
		{
			inPoint = oin;
			outPoint = oot;
			if (startOut) moveOut(0);
		}
		
		public function initWithXML(x:XML, onLoad:Function, startOut:Boolean=true):void
		{
			_gotXML = true;
			xml = x;
			inPoint = setObjectFromXML(xml.pin);
			outPoint = setObjectFromXML(xml.put);
			addImage(xml.@src, {width:xml.@width}, onLoad);
			
			if (startOut) moveOut(0);
		}
		
		public function setObjectFromXML(x:XMLList):Object
		{
			var obj:Object = new Object();
			var atts = x.attributes();
			var i:int;
			for (i = 0; i < atts.length(); i++)
			{
				var n = atts[i].name();
				obj[n.localName] = Number(x.attribute(n));
			}
			return obj;
		}


		
		public function moveOut(t,d=0):void
		{
			var dest:Object = createDest(outPoint,t,d);
			Tweener.addTween(this, dest);
			
			if (t==0) state = 'out';
			else state = 'moving';
		}
		
		public function moveIn(t,d=0):void
		{
			var dest:Object = createDest(inPoint,t,d);
			Tweener.addTween(this, dest);
			
			if (t==0) state = 'in';
			else state = 'moving';	
		}
	
		private function createDest(obj:Object,time:Number,delay:Number):Object
		{	
			var dest:Object = new Object();
			
			for(var key in obj)
			{
				dest[key] = obj[key];
			}
			
			if (dest.transition == undefined) dest['transition'] = TRANSITION;
			
			dest['time'] = time;
			dest['delay'] = delay;
						
			switch(obj)
			{
				case inPoint: dest['onComplete'] = amHere; break;
				case outPoint: dest['onComplete'] = amGone; break;
				default: trace('unknown object'); break;
			}
		
			return dest;
		}	
		
		function amHere()
		{
			state = 'in';
			dispatchEvent(new Event('HERE'));
		}
		function amGone()
		{
			state = 'out';
			dispatchEvent(new Event('GONE'));
		}
		
		*/
		
		public function bringToTop(child:*):void
		{
			addChild(removeChild(child));
		}
		
		public function addData(obj:Object)
		{
			for(var k in obj)
			{
				data[k] = obj[k];
			}
		}
	}
}