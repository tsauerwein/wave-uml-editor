package de.waveumleditor.model.classDiagram.link
{
	import de.waveumleditor.model.classDiagram.ClassDiagramNode;
	
	public class LinkAggregation extends LinkAssociation
	{
		public function LinkAggregation(linkFrom:ClassDiagramNode, linkTo:ClassDiagramNode)
		{
			super(linkFrom, linkTo);
		}

	}
}