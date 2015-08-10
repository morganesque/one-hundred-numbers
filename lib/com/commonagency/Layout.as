package com.commonagency
{
	import flash.display.Stage;
	import flash.display.DisplayObject;
	
	public class Layout extends Object 
	{	
		private static var _stage:Object;
		private static var _margin:int = 10;
		private static var _store:Array = [];
		
		public static function set stage(value:Stage):void
		{
			_stage = value;
		}
		
		/**
		*	adds the display object and params to the _store and places it within it's _stage.
		*/
		public static function add(d:DisplayObject, where:String, pos:Object=null):void
		{
			if (!pos) var p = {x:0,y:0};
			else p = pos;
			
			var o = new Object();
			o['d'] = d;
			o['w'] = where;
			o['p'] = p;
			_store.push(o);
			
			place(o.d, o.w, o.p);
		}
		
		/**
		*	takes care of the actual placement of objects 
		*/
		public static function place(d:DisplayObject, where:String, pos:Object):void
		{
			var a = where.split('-');
			switch(a[0])
			{
				case 'top':
					d.y = pos.y;
					break;
				case 'middle':
					d.y = (_stage.stageHeight - d.height)/2
					break;
				case 'bottom':
					d.y = _stage.stageHeight - d.height - pos.y;
					break;					
				default:
					Logger.debug("Layout::place() - "+a[0]+' not valid: top, middle or bottom');
					break;					
			}
			switch(a[1])
			{
				case 'left':
					d.x = pos.x;
					break;
				case 'centre':
					d.x = (_stage.stageWidth - d.width)/2;
					break;
				case 'right':
					d.x = _stage.stageWidth - pos.x;
					break;
				default:
					Logger.debug("Layout::place() - "+a[1]+' not valid: left, centre, right');
					break;
			}
		}
		
		/**
		*	allows you to set the margin that should exist between the object and the edge of the stage.
		*/
		public static function set margin(value:int):void
		{
			_margin = value;
		}
		
		/**
		*	takes each object from the store and re-places it 
		*/
		public static function updateLayout():void
		{
			for each (var o in _store)
			{
				place(o.d, o.w, o.p);
			}
		}
	}
}

