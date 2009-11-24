package de.waveumleditor.model.classDiagram
{
	public class InterfaceMethod extends ClassMethod
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