package de.waveumleditor.model.classDiagram.nodes
{
	import de.waveumleditor.model.IIdentifiable;
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.Position;
	import de.waveumleditor.model.classDiagram.maps.MethodMap;
	
	import mx.collections.IList;
	
	public class MClassDiagramNode implements IIdentifiable
	{
		private var position:Position; 
		private var name:String;
		private var methods:MethodMap;
		private var key:Identifier;
		
		public function MClassDiagramNode(key:Identifier, position:Position, name:String = "") 
		{
			this.key = key;
			this.position = position;
			this.name = name;
			this.methods = new MethodMap();
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
		
		public function addMethod(method:MClassMethod):void
		{
			method.setClassDiagramNode(this);
			methods.setValue(method);
		}
		
		public function removeMethod(method:MClassMethod):void
		{
			method.setClassDiagramNode(null);
			methods.removeValue(method.getIdentifier());
		}
		
		public function removeMethodById(methodId:Identifier):void
		{
			methods.removeValue(methodId);
		}
		
		public function getMethod(id:Identifier):MClassMethod
		{
			return methods.getValue(id);
		}
		
		public function getMethods():IList
		{
			return this.methods.getAsList();
		}
	}
}