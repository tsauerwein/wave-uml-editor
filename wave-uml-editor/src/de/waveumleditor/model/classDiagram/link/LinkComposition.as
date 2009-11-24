package de.waveumleditor.model.classDiagram.link
{
	import de.waveumleditor.model.classDiagram.ClassDiagramNode;
	
	public class LinkComposition extends LinkAssociation
	{
		public function LinkComposition(linkFrom:ClassDiagramNode, linkTo:ClassDiagramNode)
		{
			super(linkFrom, linkTo);
		}

	}
}