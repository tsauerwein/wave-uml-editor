package de.tests.waveumleditor.model.classDiagram
{
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.Position;
	import de.waveumleditor.model.classDiagram.ClassConstructorMethod;
	import de.waveumleditor.model.classDiagram.EVisibility;
	import de.waveumleditor.model.classDiagram.Type;
	import de.waveumleditor.model.classDiagram.UMLClass;
	import de.waveumleditor.model.classDiagram.Variable;
	
	import flexunit.framework.TestCase;
	
	public class ClassConstructorMethodTest extends TestCase
	{
		public function ClassConstructorMethodTest()
		{
		}
		
		public function testToString():void
		{
			var classConstructorMethod:ClassConstructorMethod = new ClassConstructorMethod(new Identifier("meth008"), EVisibility.PUBLIC);
			classConstructorMethod.setUMLClass(new UMLClass(new Identifier("1234567"), new Position(0,0), "DasIstKlasse") );
			
			assertEquals("+ DasIstKlasse()", classConstructorMethod.toString());
			
			classConstructorMethod.addVariable(new Variable("var1", Type.BOOLEAN));
			classConstructorMethod.addVariable(new Variable("var2", Type.INT, "4711"));
			assertEquals("+ DasIstKlasse(var1:boolean,var2:int=4711)", classConstructorMethod.toString());
		}
		
		public function testUpdataFrom():void
		{
			var a:ClassConstructorMethod = new ClassConstructorMethod(new Identifier("meth008"), EVisibility.PUBLIC);
			a.addVariable(new Variable("var1", Type.BOOLEAN));
			
			var b:ClassConstructorMethod = new ClassConstructorMethod(new Identifier("meth009"), EVisibility.PUBLIC);
			b.updateFrom(a);
			
			assertEquals(a.getVisibility(), b.getVisibility());
			assertEquals(a.getVariables().length, b.getVariables().length);
		}
		
		public function testClone():void
		{
			var a:ClassConstructorMethod = new ClassConstructorMethod(new Identifier("meth008"), EVisibility.PUBLIC);
			a.addVariable(new Variable("var1", Type.BOOLEAN));
			
			var b:ClassConstructorMethod = a.clone(a.getIdentifier());
			
			assertEquals(a.getIdentifier(), b.getIdentifier());
			assertEquals(a.getVisibility(), b.getVisibility());
			assertEquals(a.getVariables().length, b.getVariables().length);
		}
	}
}