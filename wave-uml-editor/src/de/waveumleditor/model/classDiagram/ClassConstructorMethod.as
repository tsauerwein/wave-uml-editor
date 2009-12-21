package de.waveumleditor.model.classDiagram
{
	import de.waveumleditor.model.Identifier;
	
	import mx.collections.ArrayList;
	import mx.collections.IList;
	
	public class ClassConstructorMethod implements IClassElement
	{
		private var visibility:EVisibility;
		private var variables:ArrayList;
		private var classDiagramNode:ClassDiagramNode;
		private var key:Identifier;
		
		public function ClassConstructorMethod(key:Identifier, visibility:EVisibility)
		{
			this.key = key;
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
		
		public function getClassDiagramNode():ClassDiagramNode
		{
			return this.classDiagramNode;
		}
		
		public function setClassDiagramNode(classDiagramNode:ClassDiagramNode):void
		{
			this.classDiagramNode = classDiagramNode;
		}
		
		public function isStatic():Boolean
		{
			return false;
		}
		
		public function isAbstract():Boolean
		{
			return false;
		}
		
		public function getIdentifier():Identifier
		{
			return this.key;
		}
		
		public function toString():String
		{
			var out:String = "";
			
			out += this.visibility.toString();
			
			out += " " + this.classDiagramNode.getName();
			
			out += "(" + this.variables.toString() + ")";
			
			return out;
		}
		
		public function updateFrom(other:ClassConstructorMethod):void
		{
			if (!(this is InterfaceMethod)) 
			{
				setVisibility(other.getVisibility());
			}
			setClassDiagramNode(other.getClassDiagramNode());
			
			// copy all parameters
			this.getVariables().removeAll();
			
			var	list:IList = other.getVariables();
			for (var i:int = 0; i < list.length; i++)
			{		
				var variable:Variable = list.getItemAt(i) as Variable;
				
				this.addVariable(variable.clone());
			}	
		}
		
		public function clone(id:Identifier):ClassConstructorMethod
		{
			var constructor:ClassConstructorMethod = new ClassConstructorMethod(id, visibility);
			
			constructor.updateFrom(this);
			
			return constructor;
		}
		
	}
}