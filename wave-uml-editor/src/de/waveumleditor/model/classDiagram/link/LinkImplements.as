package de.waveumleditor.model.classDiagram.link
{
	import de.waveumleditor.model.classDiagram.ClassDiagramNode;
	import de.waveumleditor.model.classDiagram.Interface;
	import de.waveumleditor.model.classDiagram.UMLClass;
	
	public class LinkImplements extends ClassDiagramLink	
	{
		public function LinkImplements(linkFrom:ClassDiagramNode, linkTo:ClassDiagramNode)
		{
			super(linkFrom, linkTo);
		}
		
		public override function canLink(linkFrom:ClassDiagramNode, linkTo:ClassDiagramNode):Boolean 
		{	
			if (linkFrom is UMLClass && linkTo is Interface) return true;
			
			return false;
		}
	}
}