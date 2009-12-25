package de.waveumleditor.model.classDiagram.maps
{
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.Map;
	import de.waveumleditor.model.classDiagram.nodes.MClassDiagramNode;
	
	import mx.collections.ArrayList;
	
	public class NodeMap extends AbstractMap
	{
		
		public function NodeMap()
		{
			super();
		}

		public function setValue(node:MClassDiagramNode):void
		{
			super.delegate.setValue(node);
		}
		
		public function getValue(key:Identifier):MClassDiagramNode
		{
			return super.delegate.getValue(key) as MClassDiagramNode;
		}
	}
}