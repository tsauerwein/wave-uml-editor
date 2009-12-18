package de.tests.waveumleditor.controller
{
	import com.nextgenapp.wave.gadget.WaveSimulator;
	
	import de.waveumleditor.controller.ModelFascade;
	import de.waveumleditor.model.classDiagram.ClassDiagram;
	import de.waveumleditor.view.diagrammer.classDiagram.BaseClassDiagramNode;
	import de.waveumleditor.view.diagrammer.classDiagram.ClassNode;
	
	import flexunit.framework.TestCase;
	
	import mx.collections.ArrayList;

	public class ControllerTest extends TestCase
	{
		public function ControllerTest()
		{
		}
		
		public function testAddNode():void
		{
			var diagram:ClassDiagram = new ClassDiagram();
			var list:ArrayList = diagram.getNodes();
			
			var sizeBefore:int = list.length;
			
			var cf:ModelFascade = new ModelFascade(diagram, new WaveSimulator());
			var bcdn:BaseClassDiagramNode = new ClassNode();
			
			cf.addNode(bcdn);
			assertEquals(sizeBefore + 1, diagram.getNodes().length);
		}
		
	}
}