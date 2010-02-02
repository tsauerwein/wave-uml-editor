package de.waveumleditor.model.classDiagram.nodes
{
	import de.waveumleditor.model.Identifier;
		
	public class MConstantAttribute extends MClassAttribute implements IClassElement
	{
		
		public function MConstantAttribute(key:Identifier, variable:MVariable)
		{
			super(key, variable, EVisibility.PUBLIC);
			
			super.setStatic(true);
		}
		
		/**
		 * Simulates private function. Should not be called!
		 */
		override public function setVisibility(visibility:EVisibility):void
		{
			// simulates private function - sorry
			throw new Error("should not be called");
		}
		
		/**
		 * Simulates private function. Should not be called!
		 */
		override public function setStatic(is_static:Boolean):void
		{
			// simulates private function - sorry
			throw new Error("should not be called");
		}
		
		override public function toString():String
		{
			var out:String = "";
			
			out += super.getVisibility().toString();
			out += " " + super.getVariable().toString();
			
			return out;
		}
	}
}