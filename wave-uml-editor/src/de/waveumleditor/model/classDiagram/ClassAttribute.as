package de.waveumleditor.model.classDiagram
{
	
	import mx.collections.ArrayList;
	import mx.collections.IList;
	
	public class ClassAttribute implements IClassElement
	{
		private var variable:Variable;
		private var modifiers:ArrayList;
		private var visibility:EVisibility;
		
		public function ClassAttribute(variable:Variable, visibility:EVisibility)
		{
			this.variable = variable;
			this.modifiers = new ArrayList();
			this.visibility = visibility;
		}
		
		public function getVariable():Variable
		{
			return this.variable;
		}
		
		public function setVariable(variable:Variable):void
		{
			this.variable = variable;
		}
		
		public function addModifier(modifier:EModifier):void
		{
			modifiers.addItem(modifier);
		}
		
		public function removeModifier(modifier:EModifier):void
		{
			modifiers.removeItem(modifier);
		}
		
		public function getModifiers():IList
		{
			return this.modifiers;
		}
		
		public function getVisibility():EVisibility
		{
			return this.visibility;
		}
		
		public function setVisibility(visibility:EVisibility):void
		{
			this.visibility = visibility;
		}
		
		public function toString():String
		{
			var out:String = "";
			
			out += this.visibility.toString();
						
			out += " " + this.variable;
			
			return out;
		}
		
		public function isStatic():Boolean
		{
			for each(var modifier:EModifier in this.modifiers)
			{
				if(modifier.getValue()==0) return true;
			}
			return false;
		}
		
		public function isAbstract():Boolean
		{
			return false;
		}
		
	}
}