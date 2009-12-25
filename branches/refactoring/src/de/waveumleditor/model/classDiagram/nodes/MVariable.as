package de.waveumleditor.model.classDiagram.nodes
{

	public class MVariable
	{
		private var name:String;
		private var defaultValue:String;
		private var type:MType;
		
		public function MVariable(name:String, type:MType, defaultValue:String = "")
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
		
		public function getType():MType
		{
			return this.type;
		}
		
		public function setType(type:MType):void
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
		
		public function clone():MVariable
		{

			return new MVariable(this.name, this.type, this.defaultValue);
		}
		
	}
}