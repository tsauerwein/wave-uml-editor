package de.waveumleditor.model.classDiagram.link
{
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.classDiagram.ClassDiagramNode;
	import de.waveumleditor.model.classDiagram.Interface;
	import de.waveumleditor.model.classDiagram.UMLClass;
	
	public class LinkInheritance extends ClassDiagramLink
	{
		
		public function LinkInheritance(key:Identifier, linkFrom:ClassDiagramNode, linkTo:ClassDiagramNode)
		{
			super(key, linkFrom, linkTo);
		}

		public override function canLink(linkFrom:ClassDiagramNode, linkTo:ClassDiagramNode):Boolean 
		{	
			if (linkFrom is UMLClass && linkTo is UMLClass) return true;
			if (linkFrom is Interface && linkTo is Interface) return true;
			
			return false;
		}
		
	}
}