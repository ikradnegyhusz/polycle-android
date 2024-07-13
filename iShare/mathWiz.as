package iShare
{
	public class mathWiz
	{
		public function mathWiz(){}
		public static function ang(f,s):Number
		{
			var X = s.x - f.x;var Y = s.y - f.y;
			return Math.atan2(Y, X)/Math.PI * 180;
		}
		
	}
}