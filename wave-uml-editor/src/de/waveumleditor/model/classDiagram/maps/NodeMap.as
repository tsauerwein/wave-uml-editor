package de.waveumleditor.model.classDiagram.maps
{
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.Map;
	import de.waveumleditor.model.classDiagram.ClassDiagramNode;
	
	import mx.collections.ArrayList;
	
	public class NodeMap extends AbstractMap
	{
		
		public function NodeMap()
		{
			super();
		}

		public function setValue(node:ClassDiagramNode):void
		{
			super.delegate.setValue(node);
		}
		
		public function getValue(key:Identifier):ClassDiagramNode
		{
			return super.delegate.getValue(key) as ClassDiagramNode;
		}
	}
}