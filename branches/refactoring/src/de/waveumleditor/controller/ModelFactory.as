package de.waveumleditor.controller
{
	import de.waveumleditor.model.Position;
	import de.waveumleditor.model.classDiagram.links.MAssociationLink;
	import de.waveumleditor.model.classDiagram.links.MClassLink;
	import de.waveumleditor.model.classDiagram.links.MDependencyLink;
	import de.waveumleditor.model.classDiagram.links.MImplementsLink;
	import de.waveumleditor.model.classDiagram.links.MInheritanceLink;
	import de.waveumleditor.model.classDiagram.nodes.MClassDiagramNode;
	import de.waveumleditor.model.classDiagram.nodes.MClassNode;
	import de.waveumleditor.model.classDiagram.nodes.MInterface;
	import de.waveumleditor.view.diagrammer.classDiagram.links.VAssociationLink;
	import de.waveumleditor.view.diagrammer.classDiagram.links.VClassLink;
	import de.waveumleditor.view.diagrammer.classDiagram.links.VDependencyLink;
	import de.waveumleditor.view.diagrammer.classDiagram.links.VImplementsLink;
	import de.waveumleditor.view.diagrammer.classDiagram.links.VInheritanceLink;
	import de.waveumleditor.view.diagrammer.classDiagram.nodes.VClassDiagramNode;
	import de.waveumleditor.view.diagrammer.classDiagram.nodes.VClassNode;
	import de.waveumleditor.view.diagrammer.classDiagram.nodes.VInterfaceNode;


	/**
	 * Factory to build model elements from view elements
	 */
	public class ModelFactory
	{
		/**
		 * Factory-Method to build model link elements from view link elements 
		 */
		public static function linkFromView(link:VClassLink, linkFrom:MClassDiagramNode, linkTo:MClassDiagramNode):MClassLink
		{
			if (link is VAssociationLink) 
			{
				return new MAssociationLink(link.getIdentifier(), linkFrom, linkTo);
			} 
			else if (link is VImplementsLink) 
			{
				return new MImplementsLink(link.getIdentifier(), linkFrom, linkTo);
			} 
			else if (link is VInheritanceLink) 
			{
				return new MInheritanceLink(link.getIdentifier(), linkFrom, linkTo);
			} 
			else if (link is VDependencyLink) 
			{
				return new MDependencyLink(link.getIdentifier(), linkFrom, linkTo);
			} 
			
			return null;
		}
		
		/**
		 * Factory-Method to build model node elements from view node elements 
		 */
		public static function nodeFromView(node:VClassDiagramNode):MClassDiagramNode
		{
			if (node is VClassNode) 
			{
				return new MClassNode(node.getIdentifier(), new Position(node.x, node.y), node.nodeName);
			} 
			else if (node is VInterfaceNode) 
			{
				return new MInterface(node.getIdentifier(), new Position(node.x, node.y), node.nodeName);
			} 
			
			return null;
		}
	}
}