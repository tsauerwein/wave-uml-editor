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
		private var methods:MethodMap;
		private var attributes:AttributeMap;
		
		private var abstract:Boolean;
		
		public function UMLClass(key:Identifier, position:Position, name:String = "", abstract:Boolean = false) 
		{
			super(key, position, name);
			
			this.abstract = abstract;
			
			this.constructors = new ConstructorMap();
			this.methods = new MethodMap();
			this.attributes = new AttributeMap();
		}

		public function addConstructor(constructor:ClassConstructorMethod):void
		{
			constructor.setUMLClass(this);
			constructors.setValue(constructor);
		}
		
		public function removeConstructor(constructor:ClassConstructorMethod):void
		{
			constructor.setUMLClass(null);
			constructors.removeValue(constructor.getIdentifier());
		}
		
		public function getConstructor(id:Identifier):ClassConstructorMethod
		{
			return constructors.getValue(id);
		}
		
		public function getConstructors():IList
		{
			return this.constructors.getAsList();
		}
		
		public function addMethod(method:ClassMethod):void
		{
			method.setUMLClass(this);
			methods.setValue(method);
		}
		
		public function removeMethod(method:ClassMethod):void
		{
			method.setUMLClass(null);
			methods.removeValue(method.getIdentifier());
		}
		
		public function removeMethodById(methodId:Identifier):void
		{
			methods.removeValue(methodId);
		}
		
		public function getMethod(id:Identifier):ClassMethod
		{
			return methods.getValue(id);
		}
		
		public function getMethods():IList
		{
			return this.methods.getAsList();
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
	}
}