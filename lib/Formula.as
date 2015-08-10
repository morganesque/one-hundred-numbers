package  
{
	import flash.display.Sprite;
	import flash.text.TextField;
	
	public class Formula extends Sprite 
	{
	    public var numone:TextField;
	    public var action:TextField;
	    public var numtwo:TextField;
	    public var equals:TextField;
	    public var answer:TextField;
	    
	    public var ts:Array;
	    
		public function Formula()		
		{		    		    		    
		    ts = [numone,action,numtwo,equals,answer];		    
		    var i:int;
		    for (i = 0; i < ts.length; i++)
		    {
                var t = ts[i];
		        t.autoSize = 'left';
		        t.wordWrap = false;
		        t.y = 0;
		    }		    
            doFormula(0,0);
		}
		
		public function doFormula(first,second):void
		{
		    numone.text = first;
		    numtwo.text = String(Number(second) - Number(first));
		    answer.text = second;
		    arrangeFields();
		}
		
		public function arrangeFields():void
		{
		    var i:int, prev:TextField;
		    for (i = 0; i < ts.length; i++)
		    {
		        var t = ts[i];
		        t.x = (prev) ? prev.x + prev.width : 0;   		        
		        prev = t;
	        }
		}
	}
}