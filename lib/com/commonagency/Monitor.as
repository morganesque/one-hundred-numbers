package com.commonagency
{
	import flash.display.Sprite;
	import flash.events.Event;

	public class Monitor extends Sprite 
	{
		var tex:BubbleText = new BubbleTextBox();
		
		public function Monitor()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.ENTER_FRAME, frame);
		}
		
		public function init(e:Event)
		{
			addChild(tex);
			tex.field.width = 200;
			tex.x = stage.stageWidth/2 - 200;
			tex.y = -stage.stageHeight/2;
		}
		
		public function frame(e:Event)
		{
			tex.field.text = 'kids: '+String(parent.numChildren-2);
		}
	
	}
}