package de.waveumleditor.model.classDiagram
{
	public class EModifier
	{
		
		private var value:int;
		private var name:String;
		
		public static const STATIC:EModifier = new EModifier(0, "static");
		public static const FINAL:EModifier = new EModifier(1, "final");
		public static const VOLATILE:EModifier = new EModifier(2, "volatile");
		
		public function EModifier(value:int, name:String)
		{
			this.value = value;
			this.name = name;
		}
		
		public function getValue():int
		{
			return this.value;
		}
	
		public function getName():String 
		{
			return this.name;
		}
		
		public function toString():String
		{
			return this.name;
		}

	}
}