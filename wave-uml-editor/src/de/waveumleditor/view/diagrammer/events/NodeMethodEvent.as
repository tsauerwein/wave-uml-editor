package de.waveumleditor.view.diagrammer.events
{
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.classDiagram.ClassMethod;
	import de.waveumleditor.view.diagrammer.classDiagram.ClassNode;
	import de.waveumleditor.view.diagrammer.dialogues.EditMethodsWindow;

	public class NodeMethodEvent extends NodeEvent
	{
		
		private var method:ClassMethod;
		private var methodWindow:EditMethodsWindow;
		private var methodId:Identifier;
		
		public function NodeMethodEvent(
			type:String, 
			node:ClassNode, 
			method:ClassMethod,
			methodWindow:EditMethodsWindow,
			methodId:Identifier = null)
		{
			super(type, node);
			
			this.method = method;
			this.methodWindow = methodWindow;
			
			if (methodId == null && method != null)
			{
				methodId = method.getIdentifier();
			}
		}
		
		public function getClassNode():ClassNode
		{
			return getNode() as ClassNode;
		}
		
		public function getMethod():ClassMethod
		{
			return method;
		}
		
		public function getMethodWindow():EditMethodsWindow
		{
			return methodWindow;
		}
		
		public function getMethodId():Identifier
		{
			return methodId;
		}
		
	}
}