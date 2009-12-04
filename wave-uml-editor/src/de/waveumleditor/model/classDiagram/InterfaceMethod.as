package de.waveumleditor.model.classDiagram
{
	import de.waveumleditor.model.classDiagram.IClassElement;
	import de.waveumleditor.model.Identifier;
	
	public class InterfaceMethod extends ClassMethod implements IClassElement
	{
		
		public function InterfaceMethod(key:Identifier, name:String, returnType:Type)
		{
			super(key, name, EVisibility.PUBLIC, returnType, true);
		}
		
		public override function setVisibility(visibility:EVisibility):void
		{
			// simulates private function - sorry
			throw new Error("should not be called");
		}
		
		public override function setAbstract(abstract:Boolean):void
		{
			// simulates private function - sorry
			throw new Error("should not be called");
		}
		
	}
}