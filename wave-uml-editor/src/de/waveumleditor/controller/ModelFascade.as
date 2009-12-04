package de.waveumleditor.controller
{
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.Position;
	import de.waveumleditor.model.classDiagram.ClassDiagram;
	import de.waveumleditor.model.classDiagram.ClassDiagramNode;
	import de.waveumleditor.model.classDiagram.UMLClass;
	import de.waveumleditor.model.classDiagram.link.ClassDiagramLink;
	import de.waveumleditor.model.classDiagram.link.LinkAssociation;
	import de.waveumleditor.model.classDiagram.link.LinkImplements;
	import de.waveumleditor.model.classDiagram.link.LinkInheritance;
	import de.waveumleditor.view.diagrammer.classDiagram.AssociationLink;
	import de.waveumleditor.view.diagrammer.classDiagram.BaseClassDiagramNode;
	import de.waveumleditor.view.diagrammer.classDiagram.ClassLink;
	import de.waveumleditor.view.diagrammer.classDiagram.DependencyLink;
	import de.waveumleditor.view.diagrammer.classDiagram.ImplementsLink;
	import de.waveumleditor.view.diagrammer.classDiagram.InheritanceLink;


	public class ModelFascade
	{
		private var diagram:ClassDiagram;
		
		public function ModelFascade(diagram:ClassDiagram)
		{
			this.diagram = diagram;
		}
		
		public function addClassNode(node:BaseClassDiagramNode):void
		{	
			var id:Identifier = generateNodeIdentifier();
			var umlClass:UMLClass = new UMLClass(id, new Position(node.x, node.y), "New Class");
			this.diagram.addNode(umlClass);
			node.setIdentifier(id);
			node.update(umlClass);
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
			
			this.diagram.addLink(linkFromView(link, fromNode, toNode));
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
		
		/**
		 * Factory-Method to build model elements from view elements 
		 */
		private function linkFromView(link:ClassLink, linkFrom:ClassDiagramNode, linkTo:ClassDiagramNode):ClassDiagramLink
		{
			if (link is AssociationLink) 
			{
				return new LinkAssociation(link.getIdentifier(), linkFrom, linkTo);
			} 
			else if (link is ImplementsLink) 
			{
				return new LinkImplements(link.getIdentifier(), linkFrom, linkTo);
			} 
			else if (link is InheritanceLink) 
			{
				return new LinkInheritance(link.getIdentifier(), linkFrom, linkTo);
			} 
			else if (link is DependencyLink) 
			{
				//TODO Dependency
				//return new LinkDependency(link.getIdentifier(), linkFrom, linkTo);
			} 
			
			return null;
		}
		
	}
}