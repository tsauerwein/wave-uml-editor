package de.waveumleditor.model.classDiagram
{
	public class Variable
	{
		private var name:String;
		private var defaultValue:String;
		private var type:Type;
		
		public function Variable(name:String, type:Type, defaultValue:String = "")
		{
			this.name = name;
			this.type = type;
			this.defaultValue = defaultValue;
		}


		public function getName():String
		{
			return this.name;
		}
		
		public function setName(name:String):void
		{
			this.name = name;
		}
		
		public function getDefaultValue():String
		{
			return this.defaultValue;
		}
		
		public function setDefaultValue(defaultValue:String):void
		{
			this.defaultValue = defaultValue;
		}
		
		public function getType():Type
		{
			return this.type;
		}
		
		public function setType(type:Type):void
		{
			this.type = type;
		}
		
		public function toString():String
		{
			if (defaultValue == "")
			{
				return this.name + ":" + this.type.toString();
			} else {				
				return this.name + ":" + this.type.toString() + "=" + this.defaultValue;
			}
		}
		
	}
}