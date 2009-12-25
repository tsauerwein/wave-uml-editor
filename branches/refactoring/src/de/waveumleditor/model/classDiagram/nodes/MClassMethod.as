package de.waveumleditor.model.classDiagram.nodes
{
	
	import de.waveumleditor.model.Identifier;
	
	import mx.collections.ArrayList;
	
	public class MClassMethod extends MClassConstructorMethod implements IClassElement
	{
		private var name:String;
		private var returnType:MType;
		private var statique:Boolean;
		private var abstract:Boolean;
		
		public function MClassMethod(key:Identifier, name:String, visibility:EVisibility, returnType:MType, abstract:Boolean = false, is_static:Boolean = false)
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
		
		public function getReturnType():MType
		{
			return this.returnType;
		}
		
		public function setReturnType(returnType:MType):void
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
		
		override public function updateFrom(other:MClassConstructorMethod):void
		{
			super.updateFrom(other);
			
			if (!(other is MClassMethod))
			{
				throw Error("other is not an instance of ClassMethod");
			}
			
			var method:MClassMethod = other as MClassMethod;
			
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
		override public function clone(id:Identifier):MClassConstructorMethod
		{
			var method:MClassMethod = new MClassMethod(
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