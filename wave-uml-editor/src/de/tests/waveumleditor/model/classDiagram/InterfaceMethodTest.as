package de.tests.waveumleditor.model.classDiagram
{
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.Position;
	import de.waveumleditor.model.classDiagram.InterfaceMethod;
	import de.waveumleditor.model.classDiagram.Type;
	import de.waveumleditor.model.classDiagram.UMLClass;
	
	import flexunit.framework.TestCase;
	
	public class InterfaceMethodTest extends TestCase
	{
		public function InterfaceMethodTest()
		{
		}
		
		public function testToString():void
		{
			var umlclass:UMLClass = new UMLClass(new Identifier("1234567"), new Position(0,0), "DasIstKlasse");
			var ifaceMethod:InterfaceMethod = new InterfaceMethod(new Identifier("meth009"), "method", Type.INT);
			ifaceMethod.setClassDiagramNode(umlclass);
			
			assertEquals("+ method():int", ifaceMethod.toString());
		}

	}
}