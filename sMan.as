package{
	import flash.display.MovieClip
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.events.Event;

	public class sMan extends MovieClip{
		//Sound objects
		private var Sounds:Array = new Array();
		private var Channels:Array = new Array();
		private var CTransform:SoundTransform = new SoundTransform();
		private var MuteTransform:SoundTransform = new SoundTransform();
		//Other
		private var posArray:Array = new Array();
		private var mutedArray:Array = new Array();

		public function sMan(channel_num:int = 1){
			for(var i:int = 0; i < channel_num; i++){
				Channels[i] = new SoundChannel();
				Sounds[i] = new Object();
				posArray[i] = 0;
				mutedArray[i] = false;
			}
			config();
		}
		private function config():void{
			CTransform.volume = 1;
			MuteTransform.volume = 0;
		}
		public function Mute(channel_num:int = -1):void{
			if (channel_num == -1){
				for (var i:int = 0; i < Channels.length; i++){
					Channels[i].soundTransform = MuteTransform;
					mutedArray[i] = true;
				}
			}
			else{
				Channels[channel_num].soundTransform = MuteTransform;
				mutedArray[channel_num] = true;
			}
		}
		public function unMute(channel_num:int = -1):void{
			if (channel_num == -1){
				for (var i:int = 0; i < Channels.length; i++){
					Channels[i].soundTransform = CTransform;
					mutedArray[i] = false;
				}
			}
			else{
				Channels[channel_num].soundTransform = CTransform;
				mutedArray[i] = false;
			}
		}
		public function SetVolume(value:Number):void{
			CTransform.volume = value;
		}
		public function SetMusic(Music:Object, channel_num:int = 0):void{
			
			Sounds[channel_num] = Music;
		}
		public function Play(channel_num:int = 0, amount:int = 1):void{
			if(!mutedArray[channel_num]){
				if (amount > 0){
					Channels[channel_num] = Sounds[channel_num].play(posArray[channel_num], amount);
					Channels[channel_num].soundTransform = CTransform;
				}else{
					Channels[channel_num] = Sounds[channel_num].play(posArray[channel_num], 1)
					Channels[channel_num].addEventListener(Event.SOUND_COMPLETE, RepeatSong);
				}
			}
		}
		public function Stop(channel_num = 0):void{
			posArray[channel_num] = 0;
			Channels[channel_num].stop();
		}

		public function Pause(channel_num:int = 0):void{
			posArray[channel_num] = Channels[channel_num].position;
			Channels[channel_num].stop();
		}
		private function RepeatSong(e:Event):void{
            for(var i:int = 0; i < Channels.length; i++){
                if (Channels[i] == e.currentTarget){
					var index:int = i
                }
            }
			if (!mutedArray[index]){
				Channels[index] = Sounds[index].play(0);
			}
            Channels[index].addEventListener(Event.SOUND_COMPLETE, RepeatSong);
        }
		
		public function isPlayingSound(channel_num = 0):Boolean{
			return (Channels[channel_num].position > 0)
		}
	}
}
