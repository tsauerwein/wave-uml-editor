package de.waveumleditor.model.classDiagram
{
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.Position;
	
	import mx.collections.ArrayList;
	import mx.collections.IList;
	
	public class Interface extends ClassDiagramNode implements IClassElement
	{		
		public static const TYPE:String = "I";
		
		public function Interface(key:Identifier, position:Position, name:String = "") 
		{
			super(key, position, name);
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