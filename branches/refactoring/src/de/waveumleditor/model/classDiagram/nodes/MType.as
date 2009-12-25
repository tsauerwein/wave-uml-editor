package de.waveumleditor.model.classDiagram.nodes
{
	public class MType
	{
		private var name:String;
		private var key:int;
		
		public static const STRING:MType = new MType("String");
		public static const BOOLEAN:MType = new MType("boolean");
		public static const INT:MType = new MType("int");
		public static const DOUBLE:MType = new MType("double");
		
		public function MType(name:String)
		{
			this.name = name;
		}

		public function getName():String
		{
			return this.name;
		}
		
		public function toString():String
		{
			return this.name;
		}
		
		public function clone():MType
		{
			return new MType(this.name);
		}
	}
}