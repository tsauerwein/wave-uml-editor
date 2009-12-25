package de.waveumleditor.controller
{
	import de.waveumleditor.model.classDiagram.nodes.*;
	import de.waveumleditor.model.classDiagram.links.*;
	import de.waveumleditor.view.diagrammer.classDiagram.links.*;
	import de.waveumleditor.view.diagrammer.classDiagram.nodes.*;

	
	/**
	 * Factory to build view elements from model elements
	 */
	public class ViewFactory
	{
		public static function createNode(nodeData:MClassDiagramNode):VClassDiagramNode
		{
			var node:VClassDiagramNode = null;
			
			if (nodeData is MClassNode)
			{
				node = new VClassNode();
			}
			
			if (nodeData is MInterface)
			{
				node = new VInterfaceNode();
			}
			
			node.setIdentifier(nodeData.getIdentifier());
						
			return node;
		}
		
		public static function createLink(linkData:MClassLink):VClassLink
		{
			var link:VClassLink = null;
			
			if (linkData is MInheritanceLink)
			{
				link =  new VInheritanceLink();
			}
			else if (linkData is MImplementsLink)
			{
				link = new VImplementsLink();
			}
			else if (linkData is MAssociationLink)
			{
				link = new VAssociationLink();
			}
			else if (linkData is MDependencyLink)
			{
				link = new VDependencyLink();
			}
			
			link.setIdentifier(linkData.getIdentifier());
			
			return link;
		}

	}
}