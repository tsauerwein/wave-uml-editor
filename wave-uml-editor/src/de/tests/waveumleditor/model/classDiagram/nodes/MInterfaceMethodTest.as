package de.tests.waveumleditor.model.classDiagram.nodes
{
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.Position;
	import de.waveumleditor.model.classDiagram.nodes.MInterfaceMethod;
	import de.waveumleditor.model.classDiagram.nodes.MType;
	import de.waveumleditor.model.classDiagram.nodes.MClassNode;
	
	import flexunit.framework.TestCase;
	
	public class MInterfaceMethodTest extends TestCase
	{
		public function MInterfaceMethodTest()
		{
		}
		
		public function testToString():void
		{
			var umlclass:MClassNode = new MClassNode(new Identifier("1234567"), new Position(0,0), "DasIstKlasse");
			var ifaceMethod:MInterfaceMethod = new MInterfaceMethod(new Identifier("meth009"), "method", MType.INT);
			ifaceMethod.setClassDiagramNode(umlclass);
			
			assertEquals("+ method():int", ifaceMethod.toString());
		}

	}
}