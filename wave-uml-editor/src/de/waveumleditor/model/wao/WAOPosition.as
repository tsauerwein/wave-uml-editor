package de.waveumleditor.model.wao
{
	import com.adobe.serialization.json.JSON;
	
	import de.waveumleditor.model.Position;
	import de.waveumleditor.model.wao.wave.Delta;
	
	

	public class WAOPosition
	{
		public static const X:String = "x";
		public static const Y:String = "y";
		
		
		public static function store(delta:Delta, key:String, position:Position):void
		{
			var positionData:Object = new Object();
			
			positionData[X] = position.getX();
			positionData[Y] = position.getY();
			
			var json:String = JSON.encode(positionData);
			
			delta.setValue(key, json);
		}
	}
}