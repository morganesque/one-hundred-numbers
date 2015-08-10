package com.commonagency
{
	import flash.display.Stage;
	
	public class CameraRotation
	{	
		var rotLimit:uint = 10;
		var rotAccel:uint = 10;		
		
		var camera;		// camera object to be rotated.
		var stage;		// stage object - need this for size and 
		var ox;			// orginal X rotation of camera.
		var oy;			// orginal Y rotation of camera.
	
		public function CameraRotation(cam:*, sta:Stage, rl:uint=0, ra:uint=0)
		{
			stage = sta;
			camera = cam;
			ox = cam.rotationX;
			oy = cam.rotationY;
			
			rotLimit = rl;
			rotAccel = ra;
		}
		
		public function rotateCamera():void
		{					
			var mx = ((stage.stageWidth/2) - stage.mouseX) / (stage.stageWidth/2);
			var tx = (rotLimit * mx) + oy;
			var cx = (tx - camera.rotationY)/rotAccel;
			camera.rotationY += cx;
			
			var my = ((stage.stageHeight/2) - stage.mouseY) / (stage.stageHeight/2);
			var ty = (rotLimit * my) + ox;
			var cy = (ty - camera.rotationX)/rotAccel;
			camera.rotationX += cy;			
		}
	}
}