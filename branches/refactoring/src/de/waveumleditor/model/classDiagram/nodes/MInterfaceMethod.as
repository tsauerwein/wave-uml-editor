package de.waveumleditor.model.classDiagram.nodes
{
	import de.waveumleditor.model.Identifier;
	
	public class MInterfaceMethod extends MClassMethod implements IClassElement
	{
		
		public function MInterfaceMethod(key:Identifier, name:String, returnType:MType)
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