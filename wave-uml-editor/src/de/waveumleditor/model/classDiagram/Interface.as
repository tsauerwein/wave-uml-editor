package de.waveumleditor.model.classDiagram
{
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.Position;
	
	import mx.collections.ArrayList;
	import mx.collections.IList;
	
	public class Interface extends ClassDiagramNode implements IClassElement
	{
		private var methods:ArrayList;
		
		public static const TYPE:String = "I";
		
		public function Interface(key:Identifier, position:Position, name:String = "") 
		{
			super(key, position, name);
			
			this.methods = new ArrayList();
		}
		
		public function addMethod(method:InterfaceMethod):void
		{
			methods.addItem(method);
		}
		
		public function removeMethod(method:InterfaceMethod):void
		{
			methods.removeItem(method);
		}
		
		public function getMethods():IList
		{
			return this.methods;
		}
		
		public function isAbstract():Boolean
		{
			return true;
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