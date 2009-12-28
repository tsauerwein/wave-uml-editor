package de.tests.waveumleditor.controller
{
	import com.nextgenapp.wave.gadget.WaveSimulator;
	
	import de.waveumleditor.controller.ModelFascade;
	import de.waveumleditor.model.classDiagram.MClassDiagram;
	import de.waveumleditor.view.diagrammer.classDiagram.VClassDiagram;
	import de.waveumleditor.view.diagrammer.classDiagram.nodes.VClassDiagramNode;
	import de.waveumleditor.view.diagrammer.classDiagram.nodes.VClassNode;
	
	import flexunit.framework.TestCase;
	
	import mx.collections.ArrayList;

	public class ControllerTest extends TestCase
	{
		public function ControllerTest()
		{
		}
		
		public function testAddNode():void
		{
			var diagram:MClassDiagram = new MClassDiagram();
			var diagramView:VClassDiagram = new VClassDiagram();
			
			var list:ArrayList = diagram.getNodes();
			
			var sizeBefore:int = list.length;
			
			var cf:ModelFascade = new ModelFascade(diagram, new WaveSimulator());
			var bcdn:VClassDiagramNode = new VClassNode();
			
			cf.addNode(bcdn, diagramView);
			assertEquals(sizeBefore + 1, diagram.getNodes().length);
		}
		
	}
}