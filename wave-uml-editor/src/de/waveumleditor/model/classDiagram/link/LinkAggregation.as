package de.waveumleditor.model.classDiagram.link
{
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.classDiagram.ClassDiagramNode;
	
	public class LinkAggregation extends LinkAssociation
	{
		public function LinkAggregation(key:Identifier, linkFrom:ClassDiagramNode, linkTo:ClassDiagramNode)
		{
			super(key, linkFrom, linkTo);
		}

	}
}