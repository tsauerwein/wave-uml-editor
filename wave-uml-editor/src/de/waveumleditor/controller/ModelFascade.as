package de.waveumleditor.controller
{
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.Position;
	import de.waveumleditor.model.classDiagram.ClassDiagram;
	import de.waveumleditor.model.classDiagram.ClassDiagramNode;
	import de.waveumleditor.view.diagrammer.classDiagram.BaseClassDiagramNode;
	import de.waveumleditor.view.diagrammer.classDiagram.ClassLink;

	public class ModelFascade
	{
		private var diagram:ClassDiagram;
		
		public function ModelFascade(diagram:ClassDiagram)
		{
			this.diagram = diagram;
		}
		
		public function addNode(node:BaseClassDiagramNode):void
		{	
			var id:Identifier = generateNodeIdentifier();
			node.setIdentifier(id);
			
			var modelNode:ClassDiagramNode = ModelFactory.nodeFromView(node);
			this.diagram.addNode(modelNode);
			
			node.update(modelNode);
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
		
		public function removeNode(node:BaseClassDiagramNode):void
		{
			diagram.removeNodeById(node.getIdentifier());
		}
		
		public function renameNode(node:BaseClassDiagramNode):void
		{
			diagram.getNode(node.getIdentifier()).setName(node.nodeName);
		}
		
		public function removeLink(link:ClassLink):void
		{
			diagram.removeLinkById(link.getIdentifier());
		}
		
		public function addLink(link:ClassLink):void
		{
			var id:Identifier = generateLinkIdentifier();
			link.setIdentifier(id);
			var fromNode:ClassDiagramNode = this.diagram.getNode((link.fromNode as BaseClassDiagramNode).getIdentifier());
			var toNode:ClassDiagramNode = this.diagram.getNode((link.toNode as BaseClassDiagramNode).getIdentifier());
			
			this.diagram.addLink(ModelFactory.linkFromView(link, fromNode, toNode));
		}
		
		public function getDiagram():ClassDiagram
		{
			return this.diagram;
		}
		
		public function generateNodeIdentifier():Identifier
		{
			//var nodeList:List = diagram.getNodes();
			return new Identifier("C" + new Number(int.MAX_VALUE * Math.random()).toString() );
		}
		
		public function generateLinkIdentifier():Identifier
		{
			//var nodeList:List = diagram.getNodes();
			return new Identifier("L" + new Number(int.MAX_VALUE * Math.random()).toString() );
		}
		
	}
}