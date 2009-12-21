package de.waveumleditor.view.diagrammer.events
{
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.classDiagram.ClassConstructorMethod;
	import de.waveumleditor.model.classDiagram.ClassDiagramNode;
	import de.waveumleditor.model.classDiagram.UMLClass;
	import de.waveumleditor.view.diagrammer.dialogues.EditMethods;

	public class NodeMethodEvent
	{
		
		private var method:ClassConstructorMethod;
		private var methodWindow:EditMethods;
		private var methodId:Identifier;
		private var node:ClassDiagramNode;
		
		public function NodeMethodEvent(
			node:ClassDiagramNode, 
			method:ClassConstructorMethod,
			methodWindow:EditMethods,
			methodId:Identifier = null)
		{
			this.node = node;			
			this.method = method;
			this.methodWindow = methodWindow;
			
			if (methodId == null && method != null)
			{
				this.methodId = method.getIdentifier();
			}
			else 
			{
				this.methodId = methodId;
			}
		}
		
		public function getClassNode():ClassDiagramNode
		{
			return node;
		}
		
		public function getMethod():ClassConstructorMethod
		{
			return method;
		}
		
		public function getMethodWindow():EditMethods
		{
			return methodWindow;
		}
		
		public function getMethodId():Identifier
		{
			return methodId;
		}
		
		
	}
}