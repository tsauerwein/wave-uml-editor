package de.tests.waveumleditor.controller
{
	import de.waveumleditor.controller.ModelFascade;
	import de.waveumleditor.model.classDiagram.ClassDiagram;
	import de.waveumleditor.view.diagrammer.classDiagram.BaseClassDiagramNode;
	
	import flexunit.framework.TestCase;
	
	import mx.collections.ArrayList;

	public class ControllerFascadeTest extends TestCase
	{
		public function ControllerFascadeTest()
		{
		}
		
		public function testAddNode():void
		{
			var diagram:ClassDiagram = new ClassDiagram();
			var list:ArrayList = diagram.getNodes();
			
			var sizeBefore = list.length;
			
			var cf:ModelFascade = new ModelFascade(diagram);
			var bcdn:BaseClassDiagramNode = new BaseClassDiagramNode();
			
			cf.addClassNode(bcdn);
			assertEquals(sizeBefore + 1, diagram.getNodes().length);
		}
		
	}
}