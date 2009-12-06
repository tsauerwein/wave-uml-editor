package de.waveumleditor.model.classDiagram.maps
{	
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.classDiagram.link.ClassDiagramLink;
	
	public class LinkMap extends AbstractMap
	{
		
		public function LinkMap()
		{
			super();
		}

		public function setValue(link:ClassDiagramLink):void
		{
			super.delegate.setValue(link);
		}
		
		public function getValue(key:Identifier):ClassDiagramLink
		{
			return super.delegate.getValue(key) as ClassDiagramLink;
		}
	}
}