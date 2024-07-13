
package{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.net.SharedObject;
	import flash.media.Sound;
	import flash.desktop.NativeApplication;
	import flash.display.StageQuality;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.events.AccelerometerEvent;
	import flash.sensors.Accelerometer;
	import flash.events.KeyboardEvent;
	import flash.geom.Matrix;
	import flash.ui.Keyboard;
	import iShare.textMan;
	import iShare.arrMan;
	import iShare.eGraph;
	import iShare.mathWiz;
	
	[SWF(backgroundColor="0x000000")]
	//[SWF(backgroundColor="0x191919")]
	
	public class mainDeb extends MovieClip {
		//containers
		public var co1:DisplayObjectContainer = new MovieClip();
		public var mid:DisplayObjectContainer = new MovieClip();
		public var co2:DisplayObjectContainer = new MovieClip();
		//obj
		private var player:shape;
		private var menuText:txt;
		private var pointText:txt;
		private var coinText:txt;
		private var lvlText:txt;
		private var themeSong:Sound;
		private var startSound:Sound;
		private var deathSound:Sound;
		private var soundManager:sMan;
		private var bg:Sprite;
		private var xpBar:bar;
		private var pointBar:bar;
		private var storeButton:button;
		private var settingButton:button;
		private var xtrasButton:button;
		private var pauseB:button;
		private var st:store;
		private var xt:xtras;
		private var sett:settings;
		private var col:collectable;
		public var Help:help = new help();
		private var Acc:Accelerometer = new Accelerometer();
		private var pt:txt = new txt(sw,60);
		//graphics
		private var stP:storeP = new storeP;
		private var setP:settingsP = new settingsP;
		private var extP:extrasP = new extrasP();
		private var pausP:pauseP = new pauseP;
		private var lP:livesP = new livesP;
		private var holder:Bitmap;
		private var mainSurf:Sprite = new Sprite();
		//array
		private var enemyArray:Array;
		private var playerPos:Array;
		private var avPowers:Array;
		private var bulletArray:Array;
		private var livesArray:Array;
		private var colorsArray:Array = new Array();
		//bool
		private var mouseDown:Boolean;
		private var count:Boolean;
		private var oneSec:Boolean;
		private var doBullets:Boolean;
		public var Paused:Boolean;
		private var freeze:Boolean;
		private var magnet:Boolean;
		private var dashLeft:Boolean;
		private var dashRight:Boolean;
		private var tiltRight:Boolean;
		private var tiltLeft:Boolean;
		//nums & int
		private var currentPower:int;
		private var EnemySpawnY:Number;
		private var fps:int;
		private var frameC:int;
		private var points:int;
		private var posCount:int;
		private var size:int;
		private var smoothing:Number;
		private var waveCount:int;
		private var upCount:int;
		private var coins:int;
		private var xp:int;
		private var lvl:int;
		private var maxXp:int;
		private var lives:int;
		private var rCounter:int;
		private var upPoints:int;
		private var dashC:int;
		private var sw:int = stage.stageWidth;
		private var sh:int = stage.stageHeight;
		//uint
		public var playerColor:uint=0xFFFFFF;
		private var bgColor:uint;
		private var harmColor:uint;
		private var goodColor:uint;
		//shared data
		public var sharedData = SharedObject.getLocal("t0");

		public function mainDeb() {
			// constructor code
			//sharedData.clear();
			//sharedData.data.coins = 12501;
			//sharedData.data.high = 3312;
			addChild(co1);
			addChild(mid);
			addChild(co2);
			//addChild(FPS);
			setup();
			staticSetup();
			menu();
		}
		//------------------------menu---------------------
		public function menu():void
		{
			//--------------obj-------------
			//mainsurf
			spawn(mid,mainSurf);
			if(sharedData.data.pNum>0){
			eGraph.fadeI(mainSurf,15,mainSurf.alpha,0.6);}
			else{mainSurf.alpha=0;}
			//text
			updateText(false);
			menuText.text.text = "Tap to start";
			spawn(co2,menuText, sw/2-menuText.width/2, (sh-sh/5));
			//buttons
			spawn(co2,storeButton,sw/2-storeButton.width/2,sh/2-storeButton.height/3);
			spawn(co2,settingButton,sw-sw/4-settingButton.width/2,sh/2-settingButton.height/3);
			spawn(co2,xtrasButton,sw/4-xtrasButton.width/2,sh/2-xtrasButton.height/3);
			//collectable
			if(avPowers.length>0){eGraph.fadeO(this,col,15,col.alpha,0.2,false);}
			//----------------listeners---------------
			stage.addEventListener(Event.ENTER_FRAME,menuLoop);
			NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE, deact, false, 0, true);
		}
		//-----------------------setup----------------------
		private function staticSetup():void
		{
			//----------boob----------
			if(sharedData.data.shake==null){sharedData.data.shake=true};
			if(sharedData.data.inGameText==null){sharedData.data.inGameText=2};
			if(sharedData.data.music==null){sharedData.data.music=true};
			if(sharedData.data.sound==null){sharedData.data.sound=true};
			if(sharedData.data.tilt==null){sharedData.data.tilt=false};
			if(sharedData.data.f==null){sharedData.data.f=true}
			if(sharedData.data.fl==null){sharedData.data.fl=true}
			if(sharedData.data.fs==null){sharedData.data.fs=true}
			if(sharedData.data.fw==null){sharedData.data.fw=true}
			if(sharedData.data.fup==null){sharedData.data.fup=true}
			if(sharedData.data.fk==null){sharedData.data.fk=true}
			if(sharedData.data.PUhelp==null){sharedData.data.PUhelp=true}
			//-----------array------------
			avPowers=new Array();
			enemyArray = new Array();
			for (var i:int = 0; i < enemyArray.length; i++){configEnemy(i);}
			if(sharedData.data.powerArray==null)
			{
				sharedData.data.powerArray = new Array();
				for(var m:int = 0; m < 10; m++)
				{
					var b:Boolean = false;
					sharedData.data.powerArray.push(b);
				}
			}
			else
			{
				checkAvPowers();
			}
			//sharedData.data.upgradeArray=null;
			if(sharedData.data.upgradeArray==null)
			{
				sharedData.data.upgradeArray = new Array();
				for(var h:int = 0; h < 5; h++)
				{
					var j:int = 1;
					sharedData.data.upgradeArray.push(j);
				}
			}
			makeObjArray(enemyArray, shape, 5);
			bulletArray=new Array();
			livesArray = new Array();
			//----------object----------
			//main surface
			makeMainSurf();
			//text
			menuText = new txt(sw);
			eGraph.Flash(menuText);
			pointText = new txt(sw);
			spawn(co2,pointText,sw/2-pointText.width/2,sh/12);
			coinText=new txt(sw);
			spawn(co2,coinText,sw/8-coinText.width/2.5,sh/12);
			lvlText = new txt(sw);
			spawn(co2,lvlText,sw/1.5,sh/12);
			pt.text.text = 'PAUSED';
			pt.x=sw/2-pt.width/2;pt.y=sh/2-pt.height/2;
			//pauseButton
			holder = new Bitmap(pausP);
			pauseB = new button(false,35,holder);
			//updateText();
			//sounds
			themeSong = new theme_mus();
			startSound = new start_sound();
			deathSound = new death_sound();
			//bg
			bg = new Sprite();
			for(var f:int = 0; f < 20; f++)
			{
				var X:int = Math.random()*stage.stageWidth;
				var Y:int = Math.random()*stage.stageHeight;
				bg.graphics.lineStyle(1,playerColor);
				bg.graphics.moveTo(-sw/2+X+1,-sh/2+Y+1);
				bg.graphics.lineTo(-sw/2+X,-sh/2+Y);
			}
			bg.alpha = .4;
			spawn(co1,bg,sw/2,sh/2);
			//xp
			xpBar=new bar();
			spawn(co2,xpBar,(lvlText.x + lvlText.width/2) - xpBar.width/2,lvlText.y+lvlText.height/1.8);
			//store
			holder=new Bitmap(stP);
			st = new store();
			storeButton = new button(false,100,holder);
			//xtras
			xt=new xtras();
			holder = new Bitmap(extP);
			xtrasButton = new button(false,100,holder);
			//settings
			holder=new Bitmap(setP);
			sett = new settings();
			settingButton = new button(false,100,holder);
			//col
			col = new collectable();
			//----------int num-------------
			fps = stage.frameRate;
			size = sw / 6;
			EnemySpawnY = -50;
			points = new int();
			currentPower=-1;
			if(sharedData.data.pNum==null){sharedData.data.pNum=5}
			//-------music-------
			setupMusic();
			//--------stage----------
			stage.doubleClickEnabled = true;
			stage.quality = StageQuality.HIGH;
			//--------------functions--------------
			updateXp(true);
		}
		private function makeMainSurf():void
		{
			mainSurf.graphics.clear();
			mainSurf.graphics.beginFill(bgColor);
			mainSurf.graphics.drawRect(0,0,sw*1.5,sh*1.5);
			mainSurf.graphics.endFill();
			mainSurf.cacheAsBitmap=true;
		}
		public function setupMusic():void
		{
			if (soundManager){
				soundManager.Stop(0);
				soundManager.Stop(1);
			}
			soundManager = new sMan(2);
			soundManager.SetMusic(themeSong);
			soundManager.SetVolume(1);
			soundManager.Play(0, 0);
			if (!sharedData.data.music){soundManager.Mute(0)}
			else {soundManager.unMute(0)}
			
			if (!sharedData.data.sound){soundManager.Mute(1)}
			else {soundManager.unMute(1)}
		}
		public function setup():void
		{
			//themes
			if(sharedData.data.XonArray==null)
			{
				sharedData.data.XonArray=new Array();
				for(var n:int = 0; n<5;n++)
				{
					sharedData.data.XonArray[n]=false;
				}
			}
			colorsArray=[[0x052155,0xFF00ED,0x00FFCD],[0x511818,0xf9d400,0x5BFFB2],[0x2C1658,0xcb2d6f,0x65aa8b],[0x282828,0xCD7E7E,0x7ECD82],[0,0xFFaeaa,0xaaffaa]];
			for(var i:int = 0;i<colorsArray.length;i++)
			{
				if(sharedData.data.XonArray[i])
				{
					bgColor=colorsArray[i][0];
					harmColor=colorsArray[i][1];
					goodColor=colorsArray[i][2];
					colorsArray=null;
					break;
				}
			}
			if(colorsArray!=null)
			{
				bgColor=0;
				//uiColor=0xFFFFFF;
				harmColor = 0xF55D24;
				goodColor = 0x9FFF91;
			}
			makeMainSurf();
			stage.color = bgColor;
			//boolean
			freeze=false;
			magnet=false;
			mouseDown = false;
			oneSec = false;
			count = true;
			//array
			playerPos = [];
			//int/number setup
			posCount = 0;
			waveCount = 1;
			upCount = 1;
			frameC = 0;
			smoothing = 0;
			rCounter=0;
			lives = 1;//1 by def.
			//shared data
			if(sharedData.data.coins==null){sharedData.data.coins=0}
			coins=sharedData.data.coins;
			if(sharedData.data.lvl != null){lvl = sharedData.data.lvl;}
			else{sharedData.data.lvl = 1;}
			lvl=sharedData.data.lvl;
			//trace(lvl);
			xp = sharedData.data.xp;
			//sharedData.data.upPoints=45;
			if(sharedData.data.upPoints==null){sharedData.data.upPoints=0}
			upPoints=sharedData.data.upPoints;
			maxXp = lvl*50;
			//obj setup
			player = new shape();
			player.P = true;
		}
		//------------------------deactivate----------------------
		private function deact(e:Event):void
		{
			if(!stage.contains(st)&&!stage.contains(sett)&&!stage.contains(xt)&&!stage.contains(player)){NativeApplication.nativeApplication.exit();}
			else if(stage.contains(player)&&!Paused){pause(KeyboardEvent);}
		}
		//----------------------start-------------------------
		private function start(m:MouseEvent):void
		{
			//help
			if(sharedData.data.f)
			{
				Help.showPic(this,0);
				Help.setNexts([1,6,13]);
				sharedData.data.f=false;
			}
			//sound
			soundManager.SetMusic(startSound, 1);
			soundManager.Play(1, 1);
			//Listeners
			storeButton.removeListeners();
			settingButton.removeListeners();
			xtrasButton.removeListeners();
			NativeApplication.nativeApplication.removeEventListener(KeyboardEvent.KEY_DOWN, deact);
			storeButton.removeEventListener(MouseEvent.CLICK,makeStore);
			settingButton.removeEventListener(MouseEvent.CLICK,makeSettings);
			xtrasButton.removeEventListener(MouseEvent.CLICK,makeXtras);
			stage.removeEventListener(Event.ENTER_FRAME,menuLoop);
			stage.addEventListener(Event.ENTER_FRAME,inGameLoop);
			stage.addEventListener(MouseEvent.DOUBLE_CLICK,dash);
			menuText.removeEventListener(MouseEvent.MOUSE_DOWN, start);
			mid.removeEventListener(MouseEvent.MOUSE_DOWN, start);
			pauseB.addEventListener(MouseEvent.CLICK,pause);
			if (sharedData.data.tilt){
				Acc.addEventListener(AccelerometerEvent.UPDATE, acc_update);
			} else {
				stage.addEventListener(MouseEvent.MOUSE_DOWN, hold);
				stage.addEventListener(MouseEvent.MOUSE_UP, release);
			}
			NativeApplication.nativeApplication.addEventListener(KeyboardEvent.KEY_DOWN, pause);
			//obj
			//arrMan.fadeArray(co2,enemyArray,"in");
			lives=sharedData.data.upgradeArray[2];
			setupLives();
			spawn(co1,player,sw/2,sh-sh/8);
			player.makeShape(3,size,playerColor);
			player.x = sw*0.5;
			player.Speed = sharedData.data.upgradeArray[0]+4;
			player.addUp(fps*3*(sharedData.data.upgradeArray[4]));
			eGraph.fadeO(co2,storeButton,20,storeButton.alpha);
			eGraph.fadeO(co2,settingButton,20,settingButton.alpha);
			eGraph.fadeO(co2,xtrasButton,20,settingButton.alpha);
			if(avPowers.length>0){eGraph.fadeI(col,20,col.alpha,1);
				setupCol();}
			spawn(co2,pauseB,sw-pauseB.width-pauseB.width/4,pauseB.height/4,true);
			eGraph.fadeO(co2,menuText,30,menuText.alpha);
			if(sharedData.data.pNum>0){eGraph.fadeO(mid,mainSurf,15,mainSurf.alpha,0,true);}
			pointBar=new bar();
			spawn(co2,pointBar,sw/2-pointBar.width/2,xpBar.y,true);
			//int / num
			points = 0;
			frameC = 0;
			dashC = 0;
			//bool
			count = true;
			dashRight=false;dashLeft=false;
			//----	deb	 ----
			//func
			updateText();
			checkAvPowers();
			resetEnemyCol();
			//makeStore();
		}
		//---------------spawn--------------
		private function spawn(cont:DisplayObjectContainer,obj,X:Number=0,Y:Number=0,fade:Boolean=false):void
		{
			rem(cont,obj);
			obj.x = X;
			obj.y = Y;
			cont.addChild(obj);
			if(fade){eGraph.fadeI(obj,15,0,1);}
		}
		private function makeObjArray(arr:Array,cls:Class,num:int=10):void
		{
			for (var i:int = 0; i < num; i++)
			{
				var obj:Sprite = new cls();
				arr.push(obj);
			}
		}
		//-------------hold--------------
		private function hold(m:MouseEvent):void{mouseDown=true;}
		private function release(m:MouseEvent):void{mouseDown=false;}
		private function dash(m:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_DOWN, hold);
			stage.removeEventListener(MouseEvent.DOUBLE_CLICK,dash);
			if(mouseX>sw/2){dashRight=true;dashLeft=false}
			else{dashLeft=true;dashRight=false}
			dashC=0;
		}
		//------------loops-------------
		private function inGameLoop(e:Event):void
		{
			if(Help.clear){
			Player();
			secCount();
			enemies();
			back();
			if(avPowers.length>0){collect();powers();}}
		}
		private function menuLoop(e:Event):void
		{
			if(count){secCount();if(oneSec){storeButton.addEventListener(MouseEvent.CLICK,makeStore);
				mid.addEventListener(MouseEvent.MOUSE_DOWN, start);
				menuText.addEventListener(MouseEvent.MOUSE_DOWN, start);
				settingButton.addEventListener(MouseEvent.CLICK,makeSettings);
				xtrasButton.addEventListener(MouseEvent.CLICK,makeXtras);
				frameC = 0;count=false;}}
			enemies();
			if(avPowers.length>0){collect();}
			back();
		}
		//---------player------------
		private function Player():void
		{
			//debug
			//player.immortal = true;
			//movement
			movement();
			//immortal
			if (player.immortal)
			{
				if (frameC % 30 >= 15){player.alpha = 0;}
				else{player.alpha = 0.5;}
			}
			else{player.alpha = 1;}
			//wave
			if(points>=50*upCount&&player.shapeAngles<9){
				newShape();
			}
			circif:if(player.circ){
				waveCount+=1;
				if (sharedData.data.inGameText > 0){
				textMan.renderText(this,sw/2,pointBar.y+150,'WAVE '+waveCount,sw,40,playerColor);}
				player.addUp(fps*3*(sharedData.data.upgradeArray[4]));
				player.circ=false;
				if(sharedData.data.fw){Help.showPic(this,5);sharedData.data.fw=false;}
				break circif;}
			//points
			if (oneSec&&player.shapeAngles!=9){
			points += player.shapeAngles-1+sharedData.data.upgradeArray[3];
			updatePointBar();
			pointText.text.autoSize = 'center';
			updateText();}
			if(player.immortal&&oneSec&&sharedData.data.inGameText>0)
			{
				//trace(Math.round((fps*3*(sharedData.data.upgradeArray[4]))/fps-player.c/fps)+1);
				if(player.c>0){textMan.renderText(this,sw/2,sh/2,String(Math.round((fps*3*(sharedData.data.upgradeArray[4]))/fps-player.c/fps)),sw,30);}
				else{textMan.renderText(this,sw/2,sh/2,String(Math.round((fps*3*(sharedData.data.upgradeArray[4]))/fps-rCounter/fps)),sw,30);}
			}
			//poscount		temporary
			posCount+=1;
			playerPos.push(player.x);
			if(posCount == 180)
			{
				playerPos = [];
				posCount = 0;
			}
		}
		private function playerReward(i:int):void
		{
			coins+=enemyArray[i].shapeAngles;
			if(coins>1000000000){coins = 1000000000}
			if(lvl<=45){xp+=5;}
			updateXp();
			updateText();
		}
		private function newShape():void
		{
			player.clearGraph();player.makeShape(player.shapeAngles+1,size,player.col);
			eGraph.makeParticles(this,sharedData.data.pNum,player.x+player.width/2,player.y+player.height/2,true);
			if(sharedData.data.inGameText>1){textMan.renderText(this,sw/2,coinText.y+coinText.height+10,'New Shape!',sw,20);}
			upCount+=1;
			updatePointBar();
			resetEnemyCol();
			if(sharedData.data.fs)
			{
				Help.showPic(this,3);
				sharedData.data.fs = false;
			}
		}
		//---------------lives----------------
		private function setupLives():void
		{
			for(var k:int = 0; k<livesArray.length; k++)
			{
				rem(co2,livesArray[k]);
				livesArray.splice(k,0);
			}
			for(var i:int = 0; i<lives; i++)
			{
				var l:Bitmap = new Bitmap(lP);
				spawn(co2,l);
				l.y=xpBar.y+10;
				l.x=sw-l.width-l.width*(i+0.5)-20;
				livesArray.push(l);
			}
		}
		//-----------controls-----------
		private function movement():void
		{
			if (!sharedData.data.tilt){
				if(((mouseX > sw-sw/2)&&(mouseDown)))
				{
					go(player,"right");
				}
				else if(((mouseX < sw/2)&&(mouseDown)))
				{
					go(player,"left");
				}
				else
				{
					smoothing=player.Speed/1.5;
					resetRotation(player);
				}
			}
			else{
				if(tiltLeft){
					go(player, "left");
				}
				else if(tiltRight){
					go(player, "right")
				}
				else
				{
					smoothing=player.Speed/1.5;
					resetRotation(player);
				}
			}
			//dash
			if(dashC<5)
			{
				dashC+=1;
				if(dashLeft)
				{
					go(player,'left',sharedData.data.upgradeArray[1]*2+12,false)
				}
				else if(dashRight)
				{
					go(player,'right',sharedData.data.upgradeArray[1]*2+12,false)
				}
			}
			else
			{
				stage.addEventListener(MouseEvent.MOUSE_DOWN, hold);
				stage.addEventListener(MouseEvent.DOUBLE_CLICK,dash);
			}
		}
		private function acc_update(event:AccelerometerEvent):void
		{
			if (event.accelerationX <= -0.1){
				tiltLeft = false;
				tiltRight = true;
			} else if (event.accelerationX >= 0.1){
				tiltLeft = true;
				tiltRight = false;
			} else {
				tiltLeft = false;
				tiltRight = false;
			}
		}
		private function go(obj:Object,dir:String,sp:int=-1,sm:Boolean = true):void
		{
			if(sp==-1){sp=obj.Speed}
			if(smoothing>0&&sm){smoothing-=0.3}
			else if(!sm){smoothing=0}
			if((dir=="right")&&(obj.x+obj.width/4<sw-sw/20))
			{
				obj.x += sp-smoothing;
				if(obj.rotation<10)
				{
					obj.rotation += 0.5;
				}
			}
			if((dir=="left")&&(obj.x+obj.width/2>sw/20))
			{
				obj.x -= sp-smoothing;
				if(obj.rotation>-10)
				{
					obj.rotation -= 0.5;
				}
			}
		}
		private function resetRotation(obj:Object):void
		{
			if(obj.rotation > 0){obj.rotation -= .2;}
			else{obj.rotation += .2;}
		}
		//-------------------pause-----------------
		private function pause(event=null):void
		{
			if(event.type=='keyDown'){
				event.preventDefault();event.stopImmediatePropagation()}
				
			if(!Help.clear && !Paused){
				return;
			}

			if(!Paused){
				stage.removeEventListener(Event.ENTER_FRAME,inGameLoop);
				co1.alpha=0.3;
				co2.alpha=0.3;
				pauseB.visible=false;
				stage.addEventListener(MouseEvent.MOUSE_DOWN,pause);
				soundManager.Stop();
				addChild(pt);
				Paused=true;
			}
			else{
				removeChild(pt);
				stage.addEventListener(Event.ENTER_FRAME,inGameLoop);
				co1.alpha=1;
				co2.alpha=1;
				pauseB.visible=true;
				stage.removeEventListener(MouseEvent.MOUSE_DOWN,pause);
				soundManager.SetMusic(themeSong);
				soundManager.Play(0,0);
				Paused=false;
			}
		}
		//----------------enemies------------------
		private function enemies():void
		{
			for(var i:int = 0; i < enemyArray.length;i++)
			{
				//movement
				if(!freeze)
				{
					if(!magnet||enemyArray[i].shapeAngles>=player.shapeAngles){enemyArray[i].y += enemyArray[i].Speed;enemyArray[i].rotation=-180;}
					else
					{
						enemyArray[i].rotation = mathWiz.ang(enemyArray[i],player);
						enemyArray[i].x+=Math.cos(enemyArray[i].rotation/180*Math.PI)*10;
						enemyArray[i].y+=Math.sin(enemyArray[i].rotation/180*Math.PI)*10;
					}
				}
				//respawn
				if(enemyArray[i].y > sh+enemyArray[i].height)
				{
					configEnemy(i);
				}
				//death
				if(enemyArray[i].hitTestObject(player))
				{
					if(enemyArray[i].shapeAngles >= player.shapeAngles&&!player.immortal&&!freeze){
						lives -= 1;
						setupLives();
						if (lives <= 0){
							death();
							resetEnemyCol();
						}
						death(enemyArray,i);
					}
					else if(enemyArray[i].shapeAngles < player.shapeAngles||freeze){
					playerReward(i);
					death(enemyArray,i);
					if(sharedData.data.fk){Help.showPic(this,7);sharedData.data.fk=false;}
					}
				}
			}
		}
		//config enemy
		private function configEnemy(i:int):void
		{
			rem(co1,enemyArray[i]);
			var enemy = new shape();
			var EnemySpawnX:Number=(size*5)+Math.random()*(sw-(size*10));
			enemy.immortal=false;
			enemy.rotation = 180;
			enemy.Speed = i*0.2+waveCount;
			if(!stage.contains(player))
			{
				//enemy.normA = 0.3;
				spawn(co1,enemy,EnemySpawnX,EnemySpawnY);
			}
			else
			{
				//enemy.normA = 1;
				if(i%2==0){
				var X = calcEnemyX();
				spawn(co1,enemy,X+player.width/2,EnemySpawnY);}
				else{spawn(co1,enemy,EnemySpawnX,EnemySpawnY);}
			}
			var angles:int = new int();
			angles = makeShapeChance();
			var col:uint = new uint();
			if(angles>=player.shapeAngles){col=harmColor}
			else{col=goodColor}
			enemy.makeShape(angles,size,col);
			enemyArray[i] = enemy;
		}
		public function resetEnemyCol():void
		{
			for(var i:int = 0; i < enemyArray.length;i++)
			{
				if(enemyArray[i].shapeAngles>=player.shapeAngles){enemyArray[i].col=harmColor}
				else{enemyArray[i].col=goodColor}
				if(freeze){enemyArray[i].col=0x6C82FC;}
				enemyArray[i].makeShape(enemyArray[i].shapeAngles,size,enemyArray[i].col);
			}
		}
		private function calcEnemyX():Number
		{
			var Final:Number = 0;
			for (var i:int = 0; i < playerPos.length; i++)
			{
				Final += playerPos[i];
			}
			Final = Final / playerPos.length;
			return Final;
		}
		//------------------------collectable-------------
		private function collect():void
		{
			col.y+=0.2;
			if(col.y>sw+col.height)
			{
				setupCol();
			}
		}
		private function setupCol():void
		{
			spawn(co1,col,(size*4)+Math.random()*(sw-(size*8)),-(size));
			var n:int = Math.random()*avPowers.length;
			//var n:int = 0;
			col.setPower(avPowers[n]);
		}
		//-------------------------powers---------------------
		private function powers():void
		{
			hitif:if(col.hitTestObject(player))
			{
				if(currentPower==-1)
				{
					currentPower=col.power;
					rCounter=0		//nessecary
					if(currentPower==1){bulletArray=new Array();
					doBullets=true;}
				}
				setupCol();
				break hitif;
			}
			doPower(currentPower);
		}
		private function doPower(cp:int):void
		{
			pif:if(cp==0)	//boom
			{		
				if(sharedData.data.pNum>0){
				var f:Sprite = new Sprite();
				eGraph.makeG(f,800,500);
				spawn(co2,f);
				eGraph.fadeO(co2,f,5,0.2,0);
				f=null;}
				for(var i:int = 0; i < enemyArray.length; i++)
				{
					if(player.shapeAngles>enemyArray[i].shapeAngles){
						playerReward(i);
					}
					death(enemyArray,i,false);
				}
				soundManager.SetMusic(deathSound, 1);
				soundManager.Play(1, 1);
				currentPower=-1;
			}
			else if(cp==1)	//bullets
			{
				if(frameC/10%1==0&&doBullets)
				{
					var b:Sprite=new Sprite();
					eGraph.makeG(b,5,10);
					bulletArray.push(b);
					spawn(co1,b,player.x+player.width/2-b.width,player.y-player.height/2);
				}
				for(var l:int = 0; l < bulletArray.length;l++)
				{
					bulletArray[l].y-=10;
					for(var m:int = 0; m<enemyArray.length;m++)
					{
						if(enemyArray[m].hitTestObject(bulletArray[l]))
						{
							playerReward(m);
							death(enemyArray,m);
						}
					}
					if(bulletArray[l].y<-bulletArray[l].height)
					{
						rem(co1,bulletArray[l]);
						bulletArray.splice(l,1);
					}
				}
				if(rCounter>=fps*10){doBullets=false;}
				else{rCounter+=1;}
				if(!doBullets&&bulletArray.length==0){currentPower=-1;}
			}
			else if(cp==2)	//progess
			{
				points=upCount*50+points-((upCount-1)*50);
				currentPower=-1;
			}
			else if(cp==3)	//immortal
			{
				if(!player.immortal){player.immortal=true;}
				if(rCounter>=fps*3*(sharedData.data.upgradeArray[4]))
				{
					player.immortal=false;
					currentPower=-1;
				}
				else{if(player.shapeAngles!=9){rCounter+=1;}}
			}
			else if(cp==4)	//instant level up
			{
				if(lvl<46){xp=lvl*50;}
				updateXp();
				currentPower=-1;
			}
			else if(cp==5)	//health
			{
				lives+=1;
				setupLives();
				currentPower=-1;
			}
			else if(cp==6)	//freeze
			{
				if(!freeze){
				freeze=true;
				resetEnemyCol();}
				rCounter+=1;
				if(rCounter>=fps*5)
				{
					freeze=false;
					resetEnemyCol();
					currentPower=-1;
				}
			}
			else if(cp==7)	//shrink
			{
				if(player.scaleX==1)
				{
					player.scaleX=0.5;
					player.scaleY=player.scaleX;
				}
				rCounter+=1;
				if(rCounter>=fps*5)
				{
					player.scaleX=1;
					player.scaleY=player.scaleX;
					currentPower=-1;
				}
			}
			else if(cp==8)		//coins
			{
				coins+=150;
				updateText();
				currentPower=-1;
			}
			else if(cp==9)		//magnet-p
			{
				if(!magnet){magnet=true;}
				rCounter+=1;
				if(rCounter>=fps*10)
				{
					magnet=false;
					currentPower=-1;
				}
			}
		}
		public function checkAvPowers():void
		{
			avPowers=[];
			for(var p:int = 0; p < sharedData.data.powerArray.length; p++)
			{
				if(sharedData.data.powerArray[p]==true)
				{
					avPowers.push(p)
				}
			}
		}
		//----------------sec counter--------------------
		private function secCount():void
		{
			frameC += 1;
			if(frameC/fps%1==0)
			{
				oneSec = true;
				frameC=0;
			}
			else{oneSec = false;}
		}
		//----------------death-----------------
		private function death(arr:Array=null,i:int=0,sound:Boolean=true):void
		{
			if (arr==null){
				rem(co1,player);
				eGraph.makeParticles(this,sharedData.data.pNum,player.x+player.width/2,player.y+player.height/2);
				reset();
			}
			else{
			rem(co1,arr[i]);
			eGraph.makeParticles(this,sharedData.data.pNum,arr[i].x+arr[i].width/2,arr[i].y+arr[i].height/2);
			//arr[i].y=-arr[i].height;
			configEnemy(i);}
			if(sharedData.data.shake){
				eGraph.shake(co1,2);
				}
			if(sound){soundManager.SetMusic(deathSound, 1);
			soundManager.Play(1, 1);}
		}
		private function reset():void
		{
			if(sharedData.data.fup&&(coins>=500||upPoints>=1)){Help.showPic(this,2);
			sharedData.data.fup=false}
			rem(co2,pointBar);
			pauseB.removeListeners();
			eGraph.fadeO(co2,pauseB,20,1,0,true);
			rem(co1,col);
			currentPower=-1;
			if(bulletArray.length>0){arrMan.rmArray(co1,bulletArray);bulletArray=[];}
			if(points > sharedData.data.high)
			{
				sharedData.data.high = points;
			}
			sharedData.data.lvl = lvl;
			sharedData.data.xp = xp;
			sharedData.data.coins = coins;
			sharedData.data.upPoints = upPoints;
			sharedData.flush();
			
			NativeApplication.nativeApplication.removeEventListener(KeyboardEvent.KEY_DOWN, pause);
			stage.removeEventListener(MouseEvent.MOUSE_DOWN,hold);
			stage.removeEventListener(MouseEvent.DOUBLE_CLICK,dash);
			stage.removeEventListener(MouseEvent.MOUSE_UP,release);
			stage.removeEventListener(Event.ENTER_FRAME,inGameLoop);
			stage.removeEventListener(Event.ENTER_FRAME,menuLoop);
			pauseB.removeEventListener(MouseEvent.CLICK,pause);
			
			setup();
			menu();
		}
		//-----------------makeshapechance---------
		private function makeShapeChance():int
		{
			var num:int = Math.random()*52;
			for (var i:int = 6; i > 0; i--)
			{
				if (num >= i*i){return 9-i;}
			}
			return 3;
		}
		//--------------------------xp-------------------------
		private function updateXp(first:Boolean = false):void
		{
			if(xp >= maxXp)
			{
				maxXp=lvl*50;
				updateText();
				if(!first){
					if((sharedData.data.inGameText>1))textMan.renderText(this,xpBar.x+xpBar.width/2,xpBar.y + 90,'Level Up!',sw,20);
					if(lvl<=45){upPoints+=1;
					lvl+=1;
					if(sharedData.data.fl){
						Help.showPic(this,4);sharedData.data.fl=false;}}
					xp=0;
				}
			}
			xpBar.b2.scaleX = xp/maxXp;
		}
		//---------------------------updatetxts----------------------------
		private function updateText(inGame:Boolean=true):void
		{
			if(lvl<=45){lvlText.text.text = 'lvl\n'+lvl;}
			else{lvlText.text.text = 'lvl\nMAX'}
			coinText.text.text = 'coins\n'+coins;
			if(inGame){pointText.text.text = 'score\n'+points;}
			else
			{
				if(points!=new int()){pointText.text.text = 'highscore\n' + sharedData.data.high+'\nlast score\n'+points;}
				else
				{	
					if(sharedData.data.high==null){sharedData.data.high=0}
					pointText.text.text = 'highscore\n' + sharedData.data.high;
				}
			}
		}
		//---------------------pointbar----------------
		private function updatePointBar():void
		{
			pointBar.b2.scaleX = (points-((upCount-1)*50))/(50);
			if(pointBar.b2.scaleX>1){pointBar.b2.scaleX=1;}
			if(player.shapeAngles==9){pointBar.b2.scaleX=0;}
		}
		//-----------------store-----------------
		private function makeStore(m:MouseEvent):void
		{
			removeE();
			soundManager.Stop(0);
			soundManager.Stop(1);
			addChild(st);
		}
		//-----------------settings-----------------
		private function makeSettings(m:MouseEvent):void
		{
			removeE();
			addChild(sett);
		}
		//-------------------xtras----------------------
		private function makeXtras(m:MouseEvent):void
		{
			removeE();
			addChild(xt);
		}
		//-------------------removeE-------------
		private function removeE():void
		{
			stage.removeEventListener(MouseEvent.MOUSE_DOWN,hold);
			stage.removeEventListener(MouseEvent.MOUSE_UP,release);
			stage.removeEventListener(Event.ENTER_FRAME,inGameLoop);
			stage.removeEventListener(Event.ENTER_FRAME,menuLoop);
			mid.removeEventListener(MouseEvent.MOUSE_DOWN,start);
			menuText.removeEventListener(MouseEvent.MOUSE_DOWN,start);
			removeChild(co1);
			removeChild(mid);
			removeChild(co2);
		}
		public function clearScreen():void
		{
			if(sharedData.data.pNum>0){
			var f:Sprite = new Sprite();
			eGraph.makeG(f,-1);
			spawn(co2,f);
			eGraph.fadeO(co2,f,5,0.2,0);
			f=null;}
			for(var i:int = 0; i < enemyArray.length; i++)
			{
				death(enemyArray,i,false);
			}
			soundManager.SetMusic(deathSound, 1);
			soundManager.Play(1, 1);
		}
		//----------------------bg------------------
		private function back():void
		{if(!sharedData.data.XonArray[4]){bg.rotation += 0.02;if(bg.alpha!=0.5){bg.alpha=0.5;bg.cacheAsBitmapMatrix = new Matrix();}}
		else{bg.rotation += 1;
			bg.alpha=1;bg.cacheAsBitmapMatrix = new Matrix();}}
		//-----------------rem------------------
		private function rem(cont:DisplayObjectContainer,s):void
		{
			if(s!=null){
				if(cont.contains(s)){cont.removeChild(s);}
			}
			}
		
		}
	}

