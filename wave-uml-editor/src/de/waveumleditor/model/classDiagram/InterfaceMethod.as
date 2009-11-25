package de.waveumleditor.model.classDiagram
{
	import de.waveumleditor.model.classDiagram.IClassElement;
	
	public class InterfaceMethod extends ClassMethod implements IClassElement
	{
		
		public function InterfaceMethod(name:String, returnType:Type)
		{
			super(name, EVisibility.PUBLIC, returnType, true);
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