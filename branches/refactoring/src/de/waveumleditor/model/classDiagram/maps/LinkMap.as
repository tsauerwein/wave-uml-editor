package de.waveumleditor.model.classDiagram.maps
{	
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.classDiagram.links.MClassLink;
	
	public class LinkMap extends AbstractMap
	{
		
		public function LinkMap()
		{
			super();
		}

		public function setValue(link:MClassLink):void
		{
			super.delegate.setValue(link);
		}
		
		public function getValue(key:Identifier):MClassLink
		{
			return super.delegate.getValue(key) as MClassLink;
		}
	}
}