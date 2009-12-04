package de.waveumleditor.model.classDiagram
{
	import de.waveumleditor.model.Identifier;
		
	public class ConstantAttribute extends ClassAttribute implements IClassElement
	{
		/* private var modifiers:ArrayList; */
		
		public function ConstantAttribute(key:Identifier, variable:Variable)
		{
			super(key, variable, EVisibility.PUBLIC);
			
			super.setStatic(true);
		}
		
		override public function setVisibility(visibility:EVisibility):void
		{
			// simulates private function - sorry
			throw new Error("should not be called");
		}
		
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