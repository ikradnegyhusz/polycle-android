package
{
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.Bitmap;

	public class collectable extends Sprite
	{
		//public var touched:Boolean = true;
		public var power:int = new int();
		private var boP:boomP = new boomP();
		private var buP:bulletP = new bulletP();
		private var pP:progressP = new progressP();
		private var iP:immortalP = new immortalP();
		private var lvlP:levelupP = new levelupP();
		private var hP:healthP = new healthP();
		private var frP:freezeP = new freezeP();
		private var shrP:shrinkP = new shrinkP();
		private var cP:coinsP = new coinsP();
		private var magP:magnetP = new magnetP();
		
		private var cont:Bitmap;
		public function collectable()
		{
			addEventListener(Event.ADDED_TO_STAGE,init_);
		}
		private function init_(e:Event):void
		{
			draw();
		}
		private function draw()
		{
			//this.graphics.beginFill(0xE9E600);
			this.graphics.clear();
			this.graphics.lineStyle(2,0xCC9900);
			this.graphics.drawRect(-20,-20,40,40);
			this.graphics.endFill();
		}
		public function setPower(p:int=-1):void
		{
			if(cont!=null){if(this.contains(cont)){removeChild(cont);}}
			cont=new Bitmap();
			if(p==0){cont.bitmapData = boP;}
			else if(p==1){cont.bitmapData = buP;}
			else if(p==2){cont.bitmapData = pP;}
			else if(p==3){cont.bitmapData = iP;}
			else if(p==4){cont.bitmapData = lvlP;}
			else if(p==5){cont.bitmapData = hP;}
			else if(p==6){cont.bitmapData = frP;}
			else if(p==7){cont.bitmapData = shrP;}
			else if(p==8){cont.bitmapData = cP;}
			else if(p==9){cont.bitmapData = magP;}
			cont.x=-20;cont.y=-20;
			cont.scaleX = 0.20;cont.scaleY=cont.scaleX;
			this.addChild(cont);
			power=p;
		}
	}
}