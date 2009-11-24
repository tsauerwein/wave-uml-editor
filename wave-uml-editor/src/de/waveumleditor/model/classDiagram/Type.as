package de.waveumleditor.model.classDiagram
{
	public class Type
	{
		private var name:String;
		
		public static const STRING:Type = new Type("String");
		public static const BOOLEAN:Type = new Type("boolean");
		public static const INT:Type = new Type("int");
		public static const DOUBLE:Type = new Type("double");
		
		public function Type(name:String)
		{
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
		
		public function toString():String
		{
			return this.name;
		}
	}
}