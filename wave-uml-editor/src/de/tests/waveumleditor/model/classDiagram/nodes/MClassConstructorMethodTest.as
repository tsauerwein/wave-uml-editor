package de.tests.waveumleditor.model.classDiagram.nodes
{
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.Position;
	import de.waveumleditor.model.classDiagram.nodes.MClassConstructorMethod;
	import de.waveumleditor.model.classDiagram.nodes.EVisibility;
	import de.waveumleditor.model.classDiagram.nodes.MType;
	import de.waveumleditor.model.classDiagram.nodes.MClassNode;
	import de.waveumleditor.model.classDiagram.nodes.MVariable;
	
	import flexunit.framework.TestCase;
	
	public class MClassConstructorMethodTest extends TestCase
	{
		public function MClassConstructorMethodTest()
		{
		}
		
		public function testToString():void
		{
			var classConstructorMethod:MClassConstructorMethod = new MClassConstructorMethod(new Identifier("meth008"), EVisibility.PUBLIC);
			classConstructorMethod.setClassDiagramNode(new MClassNode(new Identifier("1234567"), new Position(0,0), "DasIstKlasse") );
			
			assertEquals("+ DasIstKlasse()", classConstructorMethod.toString());
			
			classConstructorMethod.addVariable(new MVariable("var1", MType.BOOLEAN));
			classConstructorMethod.addVariable(new MVariable("var2", MType.INT, "4711"));
			assertEquals("+ DasIstKlasse(var1:boolean,var2:int=4711)", classConstructorMethod.toString());
		}
		
		public function testUpdataFrom():void
		{
			var a:MClassConstructorMethod = new MClassConstructorMethod(new Identifier("meth008"), EVisibility.PUBLIC);
			a.addVariable(new MVariable("var1", MType.BOOLEAN));
			
			var b:MClassConstructorMethod = new MClassConstructorMethod(new Identifier("meth009"), EVisibility.PUBLIC);
			b.updateFrom(a);
			
			assertEquals(a.getVisibility(), b.getVisibility());
			assertEquals(a.getVariables().length, b.getVariables().length);
		}
		
		public function testClone():void
		{
			var a:MClassConstructorMethod = new MClassConstructorMethod(new Identifier("meth008"), EVisibility.PUBLIC);
			a.addVariable(new MVariable("var1", MType.BOOLEAN));
			
			var b:MClassConstructorMethod = a.clone(a.getIdentifier());
			
			assertEquals(a.getIdentifier(), b.getIdentifier());
			assertEquals(a.getVisibility(), b.getVisibility());
			assertEquals(a.getVariables().length, b.getVariables().length);
		}
	}
}