package de.waveumleditor.view.diagrammer.classDiagram.maps
{
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.classDiagram.maps.AbstractMap;
	import de.waveumleditor.view.diagrammer.classDiagram.ClassLink;
	
	public class LinkMap extends AbstractMap
	{
		
		public function LinkMap()
		{
			super();
		}

		public function setValue(link:ClassLink):void
		{
			super.delegate.setValue(link);
		}
		
		public function getValue(key:Identifier):ClassLink
		{
			return super.delegate.getValue(key) as ClassLink;
		}
	}
}