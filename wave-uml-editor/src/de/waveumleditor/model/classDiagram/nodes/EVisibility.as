package de.waveumleditor.model.classDiagram.nodes
{
	public class EVisibility
	{
		private var value:int;
		private var name:String;
		
		public static const PUBLIC:EVisibility = new EVisibility(0, "public");
		public static const PRIVATE:EVisibility = new EVisibility(1, "private");
		public static const PROTECTED:EVisibility = new EVisibility(2, "protected");
		public static const PACKAGE:EVisibility = new EVisibility(3, "package");
		
		public function EVisibility(value:int, name:String)
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
			var out:String = "";
			
			switch(this.name)
			{
				case "private": 
					out += "-";
					break;
				case "public": 
					out += "+";
					break;
				case "package": 
					out += "~";
					break;
				case "protected": 
					out += "#";
					break;			 	
			}
			return out;
		}
		
		public static function getEVisibilityFromVal(value:int):EVisibility
		{
			switch(value)
			{
				case 0: 
					return PUBLIC;
				case 1: 
					return PRIVATE;
				case 2:
					return PROTECTED;
				case 3: 
					return PACKAGE;
			}
 	
			return new EVisibility(4, "unknown");
		}
		
	}
}