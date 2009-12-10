package de.waveumleditor.controller
{
	import de.waveumleditor.model.Position;
	import de.waveumleditor.model.classDiagram.ClassDiagramNode;
	import de.waveumleditor.model.classDiagram.Interface;
	import de.waveumleditor.model.classDiagram.UMLClass;
	import de.waveumleditor.model.classDiagram.link.ClassDiagramLink;
	import de.waveumleditor.model.classDiagram.link.LinkAssociation;
	import de.waveumleditor.model.classDiagram.link.LinkDependency;
	import de.waveumleditor.model.classDiagram.link.LinkImplements;
	import de.waveumleditor.model.classDiagram.link.LinkInheritance;
	import de.waveumleditor.view.diagrammer.classDiagram.AssociationLink;
	import de.waveumleditor.view.diagrammer.classDiagram.BaseClassDiagramNode;
	import de.waveumleditor.view.diagrammer.classDiagram.ClassLink;
	import de.waveumleditor.view.diagrammer.classDiagram.ClassNode;
	import de.waveumleditor.view.diagrammer.classDiagram.DependencyLink;
	import de.waveumleditor.view.diagrammer.classDiagram.ImplementsLink;
	import de.waveumleditor.view.diagrammer.classDiagram.InheritanceLink;
	import de.waveumleditor.view.diagrammer.classDiagram.InterfaceNode;

	/**
	 * Factory to build model elements from view elements
	 */
	public class ModelFactory
	{
		/**
		 * Factory-Method to build model link elements from view link elements 
		 */
		public static function linkFromView(link:ClassLink, linkFrom:ClassDiagramNode, linkTo:ClassDiagramNode):ClassDiagramLink
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
				return new LinkDependency(link.getIdentifier(), linkFrom, linkTo);
			} 
			
			return null;
		}
		
		/**
		 * Factory-Method to build model node elements from view node elements 
		 */
		public static function nodeFromView(node:BaseClassDiagramNode):ClassDiagramNode
		{
			if (node is ClassNode) 
			{
				return new UMLClass(node.getIdentifier(), new Position(node.x, node.y), node.nodeName);
			} 
			else if (node is InterfaceNode) 
			{
				return new Interface(node.getIdentifier(), new Position(node.x, node.y), node.nodeName);
			} 
			
			return null;
		}
	}
}