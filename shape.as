package
{
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import iShare.eGraph;
	
	public class shape extends Sprite
	{
		//obj
		private var obj:Sprite;
		//boolean
		public var immortal:Boolean;
		public var circ:Boolean;
		public var lsd:Boolean = false;
		public var P:Boolean;
		//int and num
		public var Speed:Number;
		public var shapeAngles:int;
		public var c:int = 0;
		private var size:int;
		public var col:uint;
		private var countTime:int;
		public var normA:Number;
		
		public function shape()
		{
			addEventListener(Event.ADDED_TO_STAGE, init_);
			setup();
		}
		
		private function init_(e:Event):void
		{
			eGraph.fadeI(this,40,0,normA);
		}
		
		public function addUp(inpT:int):void
		{
			c=0;
			this.immortal=true;
			countTime=inpT;
			addEventListener(Event.ENTER_FRAME,update);
		}
		
		private function update(e:Event):void
		{
			if(MovieClip(parent.parent).Paused==false&&MovieClip(parent.parent).Help.clear){c+=1;}
			if(c>countTime){
				clearGraph();
				immortal=false;
				if(this.shapeAngles!=9){makeShape(this.shapeAngles,size,col);}
				else{makeShape(3,size,col);
					MovieClip(parent.parent).clearScreen();}
				MovieClip(parent.parent).resetEnemyCol();
				c=0;removeEventListener(Event.ENTER_FRAME,update);}
		}
		
		private function setup():void
		{
			obj = new Sprite();
			Speed = 8;
			shapeAngles = 0;
			immortal = true;
			col = 0xFFFFFF;
			size = 30;
			circ=false;
			normA=1;
			P=false;
		}
		
		public function makeShape(angles:int,lineLength:int=30,color:uint = 0xFFFFFF):void
		{
			removeEventListener(Event.ENTER_FRAME,lsdLoop);
			if(P){obj.graphics.beginFill(color);}
			else{obj.graphics.lineStyle(2,color);}
			shapeAngles = angles;
			size = lineLength;
			col=color;
			if(angles<9){
				circ=false;
				var oneAngle:Number = ((angles-2) * 180) / angles;
				var currentX:int;
				var currentY:int;
				for (var i:int = 0; i < angles; i++)
				{
					var point:Point = new Point();
					point.x = currentX+Math.cos((180-oneAngle)*i/180*Math.PI)*lineLength/angles;
					point.y = Math.round(currentY+Math.sin((180-oneAngle)*i/180*Math.PI)*lineLength/angles);
					obj.graphics.lineTo(point.x,point.y);
					currentX = point.x;
					currentY = point.y;
				}
			}
			else{
				angles=9;
				circ=true;
				obj.graphics.drawCircle(lineLength/angles*Math.PI/4,lineLength/angles*Math.PI/4,lineLength/angles*Math.PI/2);
				obj.graphics.endFill();
			}
			obj.x=0;obj.y=0;
			obj.cacheAsBitmapMatrix = new Matrix();
			addChild(obj);
			if(MovieClip(parent.parent).sharedData.data.XonArray[4])
			{
				addEventListener(Event.ENTER_FRAME,lsdLoop);
			}
		}
		private function lsdLoop(e:Event):void
		{
			obj.transform.colorTransform = new ColorTransform(Math.random()*255, Math.random()*255, Math.random()*255, 1);
			obj.rotation+=1;
		}
		public function resetCount(t:int,size:int):void
		{
			for(var  i:int = 0; i < t;i++)
			{
				if(i==t-1){clearGraph();this.makeShape(3,size,0xFFB600);}
			}
		}
		public function clearGraph():void{obj.graphics.clear();}
	}
}