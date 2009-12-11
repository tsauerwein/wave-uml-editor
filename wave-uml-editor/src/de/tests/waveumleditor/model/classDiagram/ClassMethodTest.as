package de.tests.waveumleditor.model.classDiagram
{
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.Position;
	import de.waveumleditor.model.classDiagram.ClassMethod;
	import de.waveumleditor.model.classDiagram.EVisibility;
	import de.waveumleditor.model.classDiagram.Type;
	import de.waveumleditor.model.classDiagram.UMLClass;
	import de.waveumleditor.model.classDiagram.Variable;
	
	import flexunit.framework.TestCase;
	
	public class ClassMethodTest extends TestCase
	{
		public function ClassMethodTest()
		{
		}
		
		public function testToString():void
		{	
			var umlclass:UMLClass = new UMLClass(new Identifier("1234567"), new Position(0,0), "DasIstKlasse");
			var method:ClassMethod = new ClassMethod(new Identifier("meth001"), "toString", EVisibility.PUBLIC, Type.STRING);
			assertEquals("+ toString():String", method.toString());
			
			method = new ClassMethod(new Identifier("meth002"), "superMethod", EVisibility.PUBLIC, Type.STRING, true);
			method.setUMLClass(umlclass);			
			method.setStatic(true);
			method.addVariable(new Variable("var1", Type.INT, "1"));
			method.addVariable(new Variable("var2", Type.INT));
			
			assertEquals("+ superMethod(var1:int=1,var2:int):String", method.toString());
		}
		
		public function testUpdataFrom():void
		{
			var a:ClassMethod = new ClassMethod(new Identifier("meth008"), "test", EVisibility.PUBLIC, Type.INT);
			a.addVariable(new Variable("var1", Type.BOOLEAN));
			
			var b:ClassMethod = new ClassMethod(new Identifier("meth009"), "", EVisibility.PRIVATE, Type.STRING);
			b.updateFrom(a);
			
			assertEquals(a.getVisibility(), b.getVisibility());
			assertEquals(a.getVariables().length, b.getVariables().length);
			assertEquals(a.getName(), b.getName());
		}
		
		public function testClone():void
		{
			var a:ClassMethod = new ClassMethod(new Identifier("meth008"), "test", EVisibility.PUBLIC, Type.INT);
			a.addVariable(new Variable("var1", Type.BOOLEAN));
			
			var b:ClassMethod = a.clone(a.getIdentifier()) as ClassMethod;
			
			assertEquals(a.getIdentifier(), b.getIdentifier());
			assertEquals(a.getVisibility(), b.getVisibility());
			assertEquals(a.getVariables().length, b.getVariables().length);
			assertEquals(a.getName(), b.getName());
		}

	}
}