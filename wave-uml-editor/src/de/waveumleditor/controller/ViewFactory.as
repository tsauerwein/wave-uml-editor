package de.waveumleditor.controller
{
	import de.waveumleditor.model.classDiagram.ClassDiagramNode;
	import de.waveumleditor.model.classDiagram.Interface;
	import de.waveumleditor.model.classDiagram.UMLClass;
	import de.waveumleditor.model.classDiagram.link.ClassDiagramLink;
	import de.waveumleditor.model.classDiagram.link.LinkAssociation;
	import de.waveumleditor.model.classDiagram.link.LinkImplements;
	import de.waveumleditor.model.classDiagram.link.LinkInheritance;
	import de.waveumleditor.view.diagrammer.classDiagram.AssociationLink;
	import de.waveumleditor.view.diagrammer.classDiagram.BaseClassDiagramNode;
	import de.waveumleditor.view.diagrammer.classDiagram.ClassLink;
	import de.waveumleditor.view.diagrammer.classDiagram.ClassNode;
	import de.waveumleditor.view.diagrammer.classDiagram.ImplementsLink;
	import de.waveumleditor.view.diagrammer.classDiagram.InheritanceLink;
	import de.waveumleditor.view.diagrammer.classDiagram.InterfaceNode;
	
	public class ViewFactory
	{
		public static function createNode(nodeData:ClassDiagramNode):BaseClassDiagramNode
		{
			var node:BaseClassDiagramNode = null;
			
			if (nodeData is UMLClass)
			{
				node = new ClassNode();
			}
			
			if (nodeData is Interface)
			{
				node = new InterfaceNode();
			}
			
			node.setIdentifier(nodeData.getKey());
						
			return node;
		}
		
		public static function createLink(linkData:ClassDiagramLink):ClassLink
		{
			if (linkData is LinkInheritance)
			{
				return new InheritanceLink();
			}
			else if (linkData is LinkImplements)
			{
				return new ImplementsLink();
			}
			else if (linkData is LinkAssociation)
			{
				return new AssociationLink();
			}
			
			return null;
		}

	}
}