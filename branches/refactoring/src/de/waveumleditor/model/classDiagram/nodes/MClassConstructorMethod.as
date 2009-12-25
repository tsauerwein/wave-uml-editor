package de.waveumleditor.model.classDiagram.nodes
{
	import de.waveumleditor.model.Identifier;
	
	import mx.collections.ArrayList;
	import mx.collections.IList;
	
	public class MClassConstructorMethod implements IClassElement
	{
		private var visibility:EVisibility;
		private var variables:ArrayList;
		private var classDiagramNode:MClassDiagramNode;
		private var key:Identifier;
		
		public function MClassConstructorMethod(key:Identifier, visibility:EVisibility)
		{
			this.key = key;
			this.visibility = visibility;
			variables = new ArrayList();
		}

		public function addVariable(variable:MVariable):void
		{
			variables.addItem(variable);
		}
		
		public function removeVariable(variable:MVariable):void
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
		
		public function getClassDiagramNode():MClassDiagramNode
		{
			return this.classDiagramNode;
		}
		
		public function setClassDiagramNode(classDiagramNode:MClassDiagramNode):void
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
		
		public function updateFrom(other:MClassConstructorMethod):void
		{
			if (!(this is MInterfaceMethod)) 
			{
				setVisibility(other.getVisibility());
			}
			setClassDiagramNode(other.getClassDiagramNode());
			
			// copy all parameters
			this.getVariables().removeAll();
			
			var	list:IList = other.getVariables();
			for (var i:int = 0; i < list.length; i++)
			{		
				var variable:MVariable = list.getItemAt(i) as MVariable;
				
				this.addVariable(variable.clone());
			}	
		}
		
		public function clone(id:Identifier):MClassConstructorMethod
		{
			var constructor:MClassConstructorMethod = new MClassConstructorMethod(id, visibility);
			
			constructor.updateFrom(this);
			
			return constructor;
		}
		
	}
}