package
{
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
	import fl.transitions.easing.*;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import flash.display.Bitmap;
	
	public class particle extends Sprite
	{
		private var tween;
		private var tween2;
		private var color:Boolean;
		private var pP:partP = new partP();
		private var holder:Bitmap = new Bitmap(pP);
		
		private var size:int;
		private var wid:Number;
		private var hei:Number;
		public function particle(c:Boolean=false)
		{
			color=c;
			addEventListener(Event.ADDED_TO_STAGE,init_)
		}
		private function init_(e:Event):void
		{
			setup();
		}
		private function setup():void
		{
			wid = stage.stageWidth/60;
			hei = stage.stageHeight/30;
			size = 15;
			
			if(color){holder.transform.colorTransform = new ColorTransform(Math.random()*255, Math.random()*255, Math.random()*255, 1);}
			/*graphics.drawTriangles( 
			Vector.<Number>([ 
				-wid/2,-hei/2,  size,10,  0,size]));
			graphics.endFill();*/
			holder.scaleX=0.3;
			holder.scaleY=holder.scaleX;
			holder.rotation=Math.random()*360;
			addChild(holder);
			//this.cacheAsBitmap = true;
			tween = new Tween(this, "alpha", Regular.easeOut, 0.5, 0, 30);
			tween.addEventListener(TweenEvent.MOTION_FINISH, remove);
			tween2 = new Tween(this, "scaleX", Regular.easeOut, 0, 1.5, 35);
			tween2.addEventListener(TweenEvent.MOTION_CHANGE, applyScale);
		}
		private function remove(t:TweenEvent):void
		{
			parent.removeChild(this);
		}
		private function applyScale(t:TweenEvent):void
		{
			scaleY = scaleX;
		}
	}
}