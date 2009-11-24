package de.waveumleditor.model.classDiagram
{
	import mx.collections.ArrayList;
		
	public class ConstantAttribute extends ClassAttribute
	{
		/* private var modifiers:ArrayList; */
		
		public function ConstantAttribute(variable:Variable)
		{
			super(variable, EVisibility.PUBLIC);
			
			super.addModifier(EModifier.STATIC);
			super.addModifier(EModifier.FINAL);
		}
		
		override public function addModifier(modifier:EModifier):void
		{
			// simulates private function - sorry
			throw new Error("should not be called");
		}
		
		override public function removeModifier(modifier:EModifier):void
		{
			// simulates private function - sorry
			throw new Error("should not be called");
		}
		
		override public function setVisibility(visibility:EVisibility):void
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