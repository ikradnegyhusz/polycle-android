package iShare
{
	//import eGraph;
	import flash.display.MovieClip;
	import flash.display.DisplayObjectContainer;

	public class arrMan {
		public function arrMan() {}		
		//----------------rm from array----------------
		public static function rmArray(p:DisplayObjectContainer,a:Array):void
		{
			for(var i:int = 0; i<a.length;i++)
			{
				p.removeChild(a[i]);
			}
		}
		//------------------fade obj array-------------
		/*public static function fadeArray(p:DisplayObjectContainer,arr:Array,prop:String):void
		{	
			for (var i:int; i < arr.length; i++)
			{
				//fadeO(p:MovieClip,s:Sprite,tim:int = 10,to:Number=0,rm:Boolean=true)
				if(prop=='out'){eGraph.fadeO(p,arr[i],30,arr[i].alpha,0.15,false)}
				//fadeI(s:Sprite,tim:int = 10,to:Number=1)
				else if(prop=='in'){eGraph.fadeI(arr[i],30,arr[i].alpha,1)}
			}
		}*/

	}
}