package  
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.utils.Dictionary;
	import com.commonagency.cDisplay;
	import com.greensock.easing.Quint;
	import com.greensock.TweenMax;

	public class NumberSquare extends Sprite 
	{
	    public var num:TextField;
	    
	    public var squares:Dictionary = new Dictionary();
        private var _state:String = 'off';
	    
		public function NumberSquare()
		{
		    mouseChildren = false;
		}
		
		public function toggleSquare(label:String, col:uint):void
		{
		    if (squares[label]) 
		    {
		        removeChild(squares[label]);
		        squares[label] = null;
		        
		    } else addSquare(label, col);
		}
		
		public function addSquare(label:String, col:uint):void
		{
            var s = makeSquare(col);            
            //var m = makeSquare(0x000000);
            cDisplay.grid(Number(label)-1,s,3,0);
            //cDisplay.grid(Number(label)-1,m,3,0);
            //addChildAt(m,0);
            addChildAt(s,0);
            
            squares[label] = s;
		}
		
		public function makeSquare(col:uint):Sprite
		{
		    var s = new Sprite();
		    s.graphics.beginFill(col);
			s.graphics.drawRect(0,0,16,16);
			s.alpha = 0.3;
			return s;
		}
		
		public function toggleState():void
		{
		    if (_state == 'on') state = 'off';
		    else if (_state == 'off') state = 'on';
		}
		
		public function set state(value:String):void
		{
		    _state = value;
		    if (_state == 'on') grow(num.text);
		    if (_state == 'off') shrink(num.text);
		}
		
		public function get state():String
		{
		  return _state;
		}
		
		public function highlight(label:String):void
		{
		    if (squares[label])
		    {
		        squares[label].alpha = 1;
		    }
		}
		
		public function lowlight(label:String):void
		{
		    if (squares[label])
		    {
		        squares[label].alpha = 0.3;
		    }
		}
		
		public function grow(num:String):void
		{
		    if (squares[num])
		    {
		        TweenMax.to(squares[num], 0.5, {x:0, y:0, height:48, width:48, ease:Quint.easeOut});
		    }
		}
		
		public function shrink(num:String):void
		{
		    var i = uint(num)-1;
		    var px = (i % 3) * 16;
            var py = Math.floor(i / 3) * 16;
            if (squares[num])
		    {
		        TweenMax.to(squares[num], 0.5, {x:px, y:py, height:16, width:16, ease:Quint.easeIn});
		    }
		}
	}
}