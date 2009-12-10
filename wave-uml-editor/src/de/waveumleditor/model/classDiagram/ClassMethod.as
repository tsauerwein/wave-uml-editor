package de.waveumleditor.model.classDiagram
{
	
	import de.waveumleditor.model.Identifier;
	
	import mx.collections.ArrayList;
	import mx.collections.IList;
	
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
		
		public function updateFrom(other:ClassMethod):void
		{
			setVisibility(other.getVisibility());
			
			this.name = other.name;
			this.abstract = other.abstract;
			this.returnType = other.returnType.clone();
			this.statique = other.statique;
			this.abstract = other.abstract;
			
			this.getVariables().removeAll();
			
			var	list:IList = other.getVariables();
			for (var obj:Object in list)
			{		
				var variable:Variable = obj as Variable;
				
				this.addVariable(variable.clone());
			}	
		}
		
		/**
		 * Builds a copy by using the passed-in Identifier
		 * 
		 * @param id
		 */
		public function clone(id:Identifier):ClassMethod
		{
			var method:ClassMethod = new ClassMethod(
				id, 
				this.getName(), 
				this.getVisibility(), 
				this.getReturnType().clone(), 
				this.isAbstract(),
				this.isStatic()); 
			
			var	list:IList = this.getVariables();
			
			for (var obj:Object in list)
			{		
				var variable:Variable = obj as Variable;
				
				this.addVariable(variable.clone());
			}
			
			return method;
		}
		
	}
}