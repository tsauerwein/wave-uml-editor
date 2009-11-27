package de.waveumleditor.view.diagrammer.classDiagram
{
	import com.anotherflexdev.diagrammer.Diagram;
	import com.anotherflexdev.diagrammer.GenericDiagramContextPanel;
	
	public class ClassDiagramComponent extends Diagram
	{
		public function ClassDiagramComponent()
		{
		}

		
		override protected function createContextPanel():GenericDiagramContextPanel {
			return new ClassDiagramContextPanel();
		}
	}
}