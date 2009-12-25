package de.waveumleditor.view.diagrammer.classDiagram.maps
{
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.classDiagram.maps.AbstractMap;
	import de.waveumleditor.view.diagrammer.classDiagram.links.VClassLink;
	
	public class LinkMap extends AbstractMap
	{
		
		public function LinkMap()
		{
			super();
		}

		public function setValue(link:VClassLink):void
		{
			super.delegate.setValue(link);
		}
		
		public function getValue(key:Identifier):VClassLink
		{
			return super.delegate.getValue(key) as VClassLink;
		}
	}
}