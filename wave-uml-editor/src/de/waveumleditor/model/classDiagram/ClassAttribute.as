package de.waveumleditor.model.classDiagram
{
	
	import de.waveumleditor.model.Identifier;
	
	public class ClassAttribute implements IClassElement
	{
		private var variable:Variable;
		private var statique:Boolean;
		private var visibility:EVisibility;
		private var key:Identifier;
		
		public function ClassAttribute(key:Identifier, variable:Variable, visibility:EVisibility, is_static:Boolean = false)
		{
			this.key = key;
			this.variable = variable;
			this.statique = is_static;
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
		
		public function isStatic():Boolean
		{
			return this.statique;
		}
		
		public function getVisibility():EVisibility
		{
			return this.visibility;
		}
		
		public function setStatic(is_static:Boolean):void
		{
			this.statique = is_static;
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
		
		public function isAbstract():Boolean
		{
			return false;
		}
		
		public function getIdentifier():Identifier
		{
			return this.key;
		}
		
		public function updateFrom(other:ClassAttribute):void
		{
			visibility = other.visibility;
			statique = other.statique;
			variable = other.getVariable().clone();			
		}
		
		
		/**
		 * Builds a copy by using the passed in Identifier
		 * 
		 * @param id
		 */
		public function clone(id:Identifier):ClassAttribute
		{
			return new ClassAttribute(id, this.variable.clone(), this.visibility, this.statique);
		}
	}
}