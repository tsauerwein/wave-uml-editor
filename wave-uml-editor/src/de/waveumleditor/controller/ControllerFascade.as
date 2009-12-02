package de.waveumleditor.controller
{
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.Position;
	import de.waveumleditor.model.classDiagram.ClassDiagram;
	import de.waveumleditor.model.classDiagram.ClassDiagramNode;
	import de.waveumleditor.model.classDiagram.UMLClass;
	import de.waveumleditor.view.diagrammer.classDiagram.BaseClassDiagramNode;


	public class ControllerFascade
	{
		private var diagram:ClassDiagram;
		
		public function ControllerFascade(diagram:ClassDiagram)
		{
			this.diagram = diagram;
		}
		
		public function addClassNode(node:BaseClassDiagramNode):void
		{	
			var id:Identifier = generateNodeIdentifier();
			var umlclass:UMLClass = new UMLClass(id, new Position(node.x, node.y), "New Class");
			this.diagram.addNode(umlclass);
			node.setIdentifier(id);
		}
		
		public function moveNode(node:BaseClassDiagramNode):void
		{
			var id:Identifier = node.getIdentifier();
			var nodeModel:ClassDiagramNode = diagram.getNode(id);
			
			if (nodeModel != null)
			{
				nodeModel.setPosition(new Position(node.x, node.y));
			}
		}
		
		public function getDiagram():ClassDiagram
		{
			return this.diagram;
		}
		
		public function generateNodeIdentifier():Identifier
		{
			//var nodeList:List = diagram.getNodes();
			return new Identifier( new Number(int.MAX_VALUE * Math.random()).toString() );
		}
	}
}