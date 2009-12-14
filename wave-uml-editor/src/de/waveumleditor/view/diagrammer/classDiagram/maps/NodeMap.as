package de.waveumleditor.view.diagrammer.classDiagram.maps
{
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.classDiagram.maps.AbstractMap;
	import de.waveumleditor.view.diagrammer.classDiagram.BaseClassDiagramNode;
	

	public class NodeMap extends AbstractMap
	{
		
		public function NodeMap()
		{
			super();
		}

		public function setValue(node:BaseClassDiagramNode):void
		{
			super.delegate.setValue(node);
		}
		
		public function getValue(key:Identifier):BaseClassDiagramNode
		{
			return super.delegate.getValue(key) as BaseClassDiagramNode;
		}
	}
}