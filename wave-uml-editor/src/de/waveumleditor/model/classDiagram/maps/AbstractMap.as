package de.waveumleditor.model.classDiagram.maps
{
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.Map;
	
	import mx.collections.ArrayList;
	
	/**
	 * This class can be extended to write your own
	 * type-safe Map implementations.
	 * 
	 * Take a look at NodeMap for a sample usage.
	 * 
	 * @see de.waveumleditor.model.AbstractMap
	 * @see de.waveumleditor.model.classDiagram.maps.NodeMap
	 */ 
	public class AbstractMap
	{
		protected var delegate:Map;
		
		public function AbstractMap()
		{
			delegate = new Map();
		}

		public function removeValue(key:Identifier):void
		{
			delegate.removeValue(key);
		}
		
		public function getAsList():ArrayList
		{
			return delegate.getAsList();
		}

	}
}