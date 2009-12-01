package de.waveumleditor.model.classDiagram.link
{
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.classDiagram.ClassDiagramNode;
	
	public class LinkComposition extends LinkAssociation
	{
		public function LinkComposition(key:Identifier, linkFrom:ClassDiagramNode, linkTo:ClassDiagramNode)
		{
			super(key, linkFrom, linkTo);
		}

	}
}