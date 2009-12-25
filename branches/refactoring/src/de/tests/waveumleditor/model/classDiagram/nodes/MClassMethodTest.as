package de.tests.waveumleditor.model.classDiagram.nodes
{
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.Position;
	import de.waveumleditor.model.classDiagram.nodes.MClassMethod;
	import de.waveumleditor.model.classDiagram.nodes.EVisibility;
	import de.waveumleditor.model.classDiagram.nodes.MType;
	import de.waveumleditor.model.classDiagram.nodes.MClassNode;
	import de.waveumleditor.model.classDiagram.nodes.MVariable;
	
	import flexunit.framework.TestCase;
	
	public class MClassMethodTest extends TestCase
	{
		public function MClassMethodTest()
		{
		}
		
		public function testToString():void
		{	
			var umlclass:MClassNode = new MClassNode(new Identifier("1234567"), new Position(0,0), "DasIstKlasse");
			var method:MClassMethod = new MClassMethod(new Identifier("meth001"), "toString", EVisibility.PUBLIC, MType.STRING);
			assertEquals("+ toString():String", method.toString());
			
			method = new MClassMethod(new Identifier("meth002"), "superMethod", EVisibility.PUBLIC, MType.STRING, true);
			method.setClassDiagramNode(umlclass);			
			method.setStatic(true);
			method.addVariable(new MVariable("var1", MType.INT, "1"));
			method.addVariable(new MVariable("var2", MType.INT));
			
			assertEquals("+ superMethod(var1:int=1,var2:int):String", method.toString());
		}
		
		public function testUpdataFrom():void
		{
			var a:MClassMethod = new MClassMethod(new Identifier("meth008"), "test", EVisibility.PUBLIC, MType.INT);
			a.addVariable(new MVariable("var1", MType.BOOLEAN));
			
			var b:MClassMethod = new MClassMethod(new Identifier("meth009"), "", EVisibility.PRIVATE, MType.STRING);
			b.updateFrom(a);
			
			assertEquals(a.getVisibility(), b.getVisibility());
			assertEquals(a.getVariables().length, b.getVariables().length);
			assertEquals(a.getName(), b.getName());
		}
		
		public function testClone():void
		{
			var a:MClassMethod = new MClassMethod(new Identifier("meth008"), "test", EVisibility.PUBLIC, MType.INT);
			a.addVariable(new MVariable("var1", MType.BOOLEAN));
			
			var b:MClassMethod = a.clone(a.getIdentifier()) as MClassMethod;
			
			assertEquals(a.getIdentifier(), b.getIdentifier());
			assertEquals(a.getVisibility(), b.getVisibility());
			assertEquals(a.getVariables().length, b.getVariables().length);
			assertEquals(a.getName(), b.getName());
		}

	}
}