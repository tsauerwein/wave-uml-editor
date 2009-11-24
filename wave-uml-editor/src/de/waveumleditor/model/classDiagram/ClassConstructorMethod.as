package de.waveumleditor.model.classDiagram
{
	import mx.collections.ArrayList;
	import mx.collections.IList;
	
	public class ClassConstructorMethod 
	{
		private var visibility:EVisibility;
		private var variables:ArrayList;
		private var umlclass:UMLClass;
		
		public function ClassConstructorMethod(visibility:EVisibility)
		{
			this.visibility = visibility;
			variables = new ArrayList();
		}

		public function addVariable(variable:Variable):void
		{
			variables.addItem(variable);
		}
		
		public function removeVariable(variable:Variable):void
		{
			variables.removeItem(variable);
		}
		
		public function getVariables():IList
		{
			return this.variables;
		}
		
		public function getVisibility():EVisibility
		{
			return this.visibility;
		}
		
		public function setVisibility(visibility:EVisibility):void
		{
			this.visibility = visibility;
		}
		
		public function getUMLClass():UMLClass
		{
			return this.umlclass;
		}
		
		public function setUMLClass(umlclass:UMLClass):void
		{
			this.umlclass = umlclass;
		}
		
		public function toString():String
		{
			var out:String = "";
			
			out += this.visibility.toString();
			
			out += " " + this.umlclass.getName();
			
			out += "(" + this.variables.toString() + ")";
			
			return out;
		}
		
	}
}