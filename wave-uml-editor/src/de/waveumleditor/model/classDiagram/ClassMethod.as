package de.waveumleditor.model.classDiagram
{
	
	import de.waveumleditor.model.Identifier;
	
	import mx.collections.ArrayList;
	
	public class ClassMethod extends ClassConstructorMethod implements IClassElement
	{
		private var name:String;
		private var returnType:Type;
		private var statique:Boolean;
		private var abstract:Boolean;
		
		public function ClassMethod(key:Identifier, name:String, visibility:EVisibility, returnType:Type, abstract:Boolean = false, is_static:Boolean = false)
		{
			super(key, visibility);
			
			this.name = name;
			this.returnType = returnType;
			this.statique = is_static
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
		
		override public function isAbstract():Boolean
		{
			return this.abstract;
		}
		
		public function setAbstract(abstract:Boolean):void
		{
			this.abstract = abstract;
		}
		
		public function setStatic(is_static:Boolean):void
		{
			this.statique = is_static;
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
		
		override public function isStatic():Boolean
		{
			return this.statique;
		}
		
		override public function updateFrom(other:ClassConstructorMethod):void
		{
			super.updateFrom(other);
			
			if (!(other is ClassMethod))
			{
				throw Error("other is not an instance of ClassMethod");
			}
			
			var method:ClassMethod = other as ClassMethod;
			
			this.name = method.name;
			this.abstract = method.abstract;
			this.returnType = method.returnType.clone();
			this.statique = method.statique;
		}
		
		/**
		 * Builds a copy by using the passed-in Identifier
		 * 
		 * @param id
		 */
		override public function clone(id:Identifier):ClassConstructorMethod
		{
			var method:ClassMethod = new ClassMethod(
				id, 
				this.getName(), 
				this.getVisibility(), 
				this.getReturnType().clone(), 
				this.isAbstract(),
				this.isStatic()); 
			
			method.updateFrom(this);
			
			return method;
		}
		
	}
}