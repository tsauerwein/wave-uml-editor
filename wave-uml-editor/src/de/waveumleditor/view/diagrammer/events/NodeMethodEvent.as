package de.waveumleditor.view.diagrammer.events
{
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.classDiagram.nodes.MClassConstructorMethod;
	import de.waveumleditor.model.classDiagram.nodes.MClassDiagramNode;
	import de.waveumleditor.model.classDiagram.nodes.MClassNode;
	import de.waveumleditor.view.diagrammer.dialogues.EditMethods;

	public class NodeMethodEvent
	{
		
		private var method:MClassConstructorMethod;
		private var methodWindow:EditMethods;
		private var methodId:Identifier;
		private var node:MClassDiagramNode;
		
		public function NodeMethodEvent(
			node:MClassDiagramNode, 
			method:MClassConstructorMethod,
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
		
		public function getClassNode():MClassDiagramNode
		{
			return node;
		}
		
		public function getMethod():MClassConstructorMethod
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