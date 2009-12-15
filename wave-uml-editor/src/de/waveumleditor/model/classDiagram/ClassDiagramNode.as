package de.waveumleditor.model.classDiagram
{
	import de.waveumleditor.model.IIdentifiable;
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.Position;
	
	public class ClassDiagramNode implements IIdentifiable
	{
		private var position:Position; 
		private var name:String;
		
		private var key:Identifier;
		
		public function ClassDiagramNode(key:Identifier, position:Position, name:String = "") 
		{
			this.key = key;
			this.position = position;
			this.name = name;
		}

		public function getPosition():Position
		{
			return this.position;
		}
		
		public function setPosition(position:Position):void
		{
			this.position = position;
		}
		
		public function getName():String
		{
			return this.name;
		}
		
		public function setName(name:String):void 
		{
			this.name = name;
		}
		
		public function getIdentifier():Identifier
		{
			return this.key;
		}
		
		public function toString():String
		{			
			return this.name;
		}
		
		public function getType():String
		{
			throw new Error("must be overriden in child classes");
		}
		
	}
}