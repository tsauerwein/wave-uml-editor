package de.waveumleditor.model.classDiagram
{
	import de.waveumleditor.model.Position;
	
	import mx.collections.ArrayList;
	import mx.collections.IList;
	
	public class UMLClass extends ClassDiagramNode
	{
		private var constructors:ArrayList;
		private var methods:ArrayList;
		private var attributes:ArrayList;
		private var abstract:Boolean;
		
		public function UMLClass(position:Position, name:String = "", abstract:Boolean = false) 
		{
			super(position, name);
			
			this.abstract = abstract;
			
			this.constructors = new ArrayList();
			this.methods = new ArrayList();
			this.attributes = new ArrayList();
		}

		public function addConstructor(constructor:ClassConstructorMethod):void
		{
			constructor.setUMLClass(this);
			constructors.addItem(constructor);
		}
		
		public function removeConstructor(constructor:ClassConstructorMethod):void
		{
			constructor.setUMLClass(null);
			constructors.removeItem(constructor);
		}
		
		public function getConstructors():IList
		{
			return this.constructors;
		}
		
		public function addMethod(method:ClassMethod):void
		{
			method.setUMLClass(this);
			methods.addItem(method);
		}
		
		public function removeMethod(method:ClassMethod):void
		{
			method.setUMLClass(null);
			methods.removeItem(method);
		}
		
		public function getMethods():IList
		{
			return this.methods;
		}
		
		public function addAttribute(attribute:ClassAttribute):void
		{
			attributes.addItem(attribute);
		}
		
		public function removeAttribute(attribute:ClassAttribute):void
		{
			attributes.removeItem(attribute);
		}
		
		public function getAttributes():IList
		{
			return this.attributes;
		}
		
		public function isAbstract():Boolean
		{
			return this.abstract;
		}
		
		public function setAbstract(abstract:Boolean):void
		{
			this.abstract = abstract;
		}

	}
}