package de.waveumleditor.model.classDiagram
{
	import mx.collections.ArrayList;
	
	public class ClassMethod extends ClassConstructorMethod
	{
		private var name:String;
		private var returnType:Type;
		private var modifiers:ArrayList;
		private var abstract:Boolean;
		
		public function ClassMethod(name:String, visibility:EVisibility, returnType:Type, abstract:Boolean = false)
		{
			super(visibility);
			
			this.name = name;
			this.returnType = returnType;
			this.modifiers = new ArrayList();
			this.abstract = abstract;
		}
		
		public function getName():String
		{
			return this.name;
		}
		
		public function setName(name:String):void
		{
			this.name = name;
		}
		
		public function getReturnType():Type
		{
			return this.returnType;
		}
		
		public function setReturnType(returnType:Type):void
		{
			this.returnType = returnType;
		}
		
		public function getModifiers():ArrayList
		{
			return this.modifiers;
		}
		
		public function addModifier(modifier:EModifier):void
		{
			modifiers.addItem(modifier);
		}
		
		public function removeModifier(modifier:EModifier):void
		{
			modifiers.removeItem(modifier);
		}
		
		public function isAbstract():Boolean
		{
			return this.abstract;
		}
		
		public function setAbstract(abstract:Boolean):void
		{
			this.abstract = abstract;
		}
		
		override public function toString():String
		{
			var out:String = "";
			
			out += super.getVisibility().toString();
			
			out += " " + name;
			
			var list:ArrayList = super.getVariables() as ArrayList; 
			
			out += "(" + list.toString() +")";
			
			out += ":" + returnType.toString();

			return out;
		}
		
	}
}