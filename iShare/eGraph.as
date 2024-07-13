package iShare
{
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.DisplayObjectContainer;
	import flash.display.Bitmap;
	import flash.geom.ColorTransform;
	
	/*
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
	import fl.transitions.easing.*;
	*/

	public class eGraph
	{
		public function eGraph()
		{
		}
		public static function makeG(s:Sprite,w:int=20,h:int=20,c:uint=0xFFFFFF):void
		{
			s.graphics.beginFill(c);
			if(w>-1){
			s.graphics.drawRect(0,0,w,h);}
			else{
			s.graphics.drawRect(0,0,640,360);
			}
			s.graphics.endFill();
		}
		public static function fadeO(p:DisplayObjectContainer,s,am:int = 10,from:Number=1,to:Number=0,rm:Boolean=true):void
		{
			s.alpha=from;
			s.addEventListener(Event.ENTER_FRAME,ef);
			function ef(e:Event):void
			{
				s.alpha-=am/1000;
				if(s.alpha<=to)
				{
					s.alpha=to;
					if(rm){MovieClip(p).removeChild(s);}
					s.removeEventListener(Event.ENTER_FRAME,ef);
				}
			}
		}
		public static function fadeI(s,am:int = 10,from:Number=0,to:Number=1)
		{
			s.alpha = from;
			s.addEventListener(Event.ENTER_FRAME,ef);
			function ef(e:Event):void
			{
				s.alpha+=am/1000;
				if(s.alpha>=to)
				{
					s.alpha=to;
					s.removeEventListener(Event.ENTER_FRAME,ef);
				}
			}
		}
		public static function Flash(s:Sprite):void
		{
			s.addEventListener(Event.ENTER_FRAME,ef);
			function ef(e:Event):void
			{
				s.alpha-=0.02;
				if(s.alpha<=0.2)
				{
					s.alpha=0.2;
					s.removeEventListener(Event.ENTER_FRAME,ef);
					s.addEventListener(Event.ENTER_FRAME,ef2);
				}
			}
			function ef2(e:Event):void
			{
				s.alpha+=0.02;
				if(s.alpha>=1)
				{
					s.alpha=1;
					s.removeEventListener(Event.ENTER_FRAME,ef2);
					s.addEventListener(Event.ENTER_FRAME,ef);
				}
			}
		}
		public static function makeParticles(p:MovieClip,amount:int = 10,X:Number = 0, Y:Number = 0,c = false):void
		{
			var sw:int = p.stage.stageWidth;
			var sh:int = p.stage.stageHeight;
			for (var i:int = 0; i < amount; i++)
			{
				var part = new particle(c);
				part.x = X-sw/25+Math.random()*sw/25;
				part.y = Y-sw/25+Math.random()*sw/25;
				MovieClip(p).addChild(part);
			}
		}/*
		public static function shake(s):void
		{
			var c:int = 0;
			var rR:Boolean = false;
			s.addEventListener(Event.ENTER_FRAME,l);
			function l(e:Event):void
			{
				c+=1;
				if(s.rotation>=5){rR=true}
				else if (s.rotation<=-5){rR=false}
				if(rR){s.rotation +=1}
				else{s.rotation-=1}
				if(c>=20)
				{
					s.rotation = 0;
					s.removeEventListener(Event.ENTER_FRAME,l);
				}
			}
		}*/
		public static function shake(s,a:int = 2,rot:Boolean=false):void
		{
			var c:int = 0;
			var rR:Boolean = false;
			s.addEventListener(Event.ENTER_FRAME,l);
			function l(e:Event):void
			{
				c+=1;
				if(s.x>=a*5){rR=false}
				else if (s.x<=-(a*5)){rR=true}
				if(rR){s.x +=Math.random()*a;s.y +=Math.random()*a;if(rot){s.rotation+=a}}
				else{s.x-=Math.random()*a;s.y-=Math.random()*a;if(rot){s.rotation-=a}}
				if(c>=5)
				{
					s.x = 0;
					s.y=0;
					s.rotation = 0;
					s.removeEventListener(Event.ENTER_FRAME,l);
				}
			}
		}
	}
}