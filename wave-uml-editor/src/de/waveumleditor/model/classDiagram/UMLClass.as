package de.waveumleditor.model.classDiagram
{
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.Position;
	import de.waveumleditor.model.classDiagram.maps.AttributeMap;
	import de.waveumleditor.model.classDiagram.maps.ConstructorMap;
	import de.waveumleditor.model.classDiagram.maps.MethodMap;
	
	import mx.collections.IList;
	
	public class UMLClass extends ClassDiagramNode implements IClassElement
	{
		private var constructors:ConstructorMap;
		
		private var attributes:AttributeMap;
		
		private var abstract:Boolean;
		
		public static const TYPE:String = "C";
		
		public function UMLClass(key:Identifier, position:Position, name:String = "", abstract:Boolean = false) 
		{
			super(key, position, name);
			
			this.abstract = abstract;
			
			this.constructors = new ConstructorMap();
			this.attributes = new AttributeMap();
		}

		public function addConstructor(constructor:ClassConstructorMethod):void
		{
			constructor.setClassDiagramNode(this);
			constructors.setValue(constructor);
		}
		
		public function removeConstructor(constructor:ClassConstructorMethod):void
		{
			constructor.setClassDiagramNode(null);
			constructors.removeValue(constructor.getIdentifier());
		}
		
		public function removeConstructorById(constructorId:Identifier):void
		{
			constructors.removeValue(constructorId);
		}
		
		public function getConstructor(id:Identifier):ClassConstructorMethod
		{
			return constructors.getValue(id);
		}
		
		public function getConstructors():IList
		{
			return this.constructors.getAsList();
		}
		
		public function addAttribute(attribute:ClassAttribute):void
		{
			attributes.setValue(attribute);
		}
		
		public function removeAttribute(attribute:ClassAttribute):void
		{
			attributes.removeValue(attribute.getIdentifier());
		}
		
		public function removeAttributeById(attributeId:Identifier):void
		{
			attributes.removeValue(attributeId);
		}
		
		public function getAttribute(id:Identifier):ClassAttribute
		{
			return attributes.getValue(id);
		}
		
		public function getAttributes():IList
		{
			return this.attributes.getAsList();
		}
		
		public function isAbstract():Boolean
		{
			return this.abstract;
		}
		
		public function setAbstract(abstract:Boolean):void
		{
			this.abstract = abstract;
		}
		
		public function isStatic():Boolean
		{
			return false;
		}
		
		override public function getType():String
		{
			return TYPE;
		} 
	}
}