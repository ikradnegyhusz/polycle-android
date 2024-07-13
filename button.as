package
{
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	import iShare.eGraph;

	public class button extends Sprite
	{
		private var outline:Boolean;
		private var grap:Sprite;
		private var T:txt;
		private var l:int;
		private var p:Bitmap;
		private var normA:Number = 1;
		private var selS:select_sound = new select_sound();
		private var soundManager:sMan = new sMan(0);
		//other
		private var func;//needed to add/remove eventlistener

		public function button(mt:Boolean = true,size:int=50,pic:Bitmap=null,out:Boolean=true)
		{
			soundManager.SetMusic(selS,0);
			grap=new Sprite();
			p=pic;
			l=size;
			outline = out;
			makeGrap();
			if(mt){T=new txt(l*5);makeT();}
			if(p!=null){makeP();}
			this.addEventListener(Event.ADDED_TO_STAGE, init_);
		}
		private function init_(e:Event):void
		{
			addEventListener(MouseEvent.MOUSE_OUT,mO);
			addEventListener(MouseEvent.MOUSE_UP,mU);
			addEventListener(MouseEvent.MOUSE_DOWN,mI);
			eGraph.fadeI(this,15,0,normA);
		}
		private function mO(m:MouseEvent):void{this.alpha = normA;}
		private function mU(m:MouseEvent):void{this.alpha = normA;}
		private function mI(m:MouseEvent):void{
			this.alpha = 0.2
			try{
				if(MovieClip(parent.parent).sharedData.data.sound)
				{
					soundManager.Play(0,1);
				}
			}
			catch(RefereneError){
				//
			}
		}
		private function makeGrap(color:uint = 0xFFFFFF):void
		{
			if (outline){
				grap.graphics.lineStyle(2,color, 0.2);
				grap.graphics.lineTo(l,0);
				grap.graphics.lineTo(l,l);
				grap.graphics.lineTo(0,l);
				grap.graphics.lineTo(0,0);
				grap.graphics.beginFill(color,0);
				grap.graphics.drawRect(0,0,l,l);
				grap.graphics.endFill();
				addChild(grap);
			}
		}
		public function setcolor(c:uint):void
		{
			grap.graphics.clear();
			makeGrap(c);
		}
		private function makeT():void
		{
			T.text.height=30;
			T.text.width = l;
			T.text.text='Name';
			T.y = l;
			addChild(T);
		}
		private function makeP():void
		{
			p.x = grap.x;
			p.y = grap.y;
			p.width = l;
			p.height = l;
			addChild(p);
		}
		public function settext(s:String):void{T.text.text = s;}
		public function setBoxSize(w:int,h:int)
		{
			if(h>-1){T.text.height=h;}
			if(w>-1){T.text.width=w;}
		}
		public function setClick(f:Function):void{
			this.addEventListener(MouseEvent.CLICK, func = function(e:MouseEvent){f()});
		}
		public function removeClick(f:Function):void{
			this.removeEventListener(MouseEvent.CLICK, func);
		}
		public function setAlpha(n:Number):void
		{
			this.alpha = n;
			normA = n;
		}
		public function removeListeners():void
		{
			removeEventListener(MouseEvent.MOUSE_OUT,mO);
			removeEventListener(MouseEvent.MOUSE_UP,mU);
			removeEventListener(MouseEvent.MOUSE_DOWN,mI);
		}
	}
}
