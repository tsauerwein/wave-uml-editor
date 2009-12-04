package de.waveumleditor.model.classDiagram
{
	public class Type
	{
		private var name:String;
		private var key:int;
		
		public static const STRING:Type = new Type(0, "String");
		public static const BOOLEAN:Type = new Type(1, "boolean");
		public static const INT:Type = new Type(2, "int");
		public static const DOUBLE:Type = new Type(3, "double");
		
		public function Type(key:int, name:String)
		{
			this.key = key;
			this.name = name;
		}

		public function getName():String
		{
			return this.name;
		}
		
		public function setName(name:String):void
		{
			this.name = name;
		}
		
		public function getKey():int
		{
			return this.key;
		}
		
		public function toString():String
		{
			return this.name;
		}
	}
}