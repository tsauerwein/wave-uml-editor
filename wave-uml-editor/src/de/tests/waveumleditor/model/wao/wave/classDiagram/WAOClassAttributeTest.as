package de.tests.waveumleditor.model.wao.wave.classDiagram
{
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.classDiagram.ClassAttribute;
	import de.waveumleditor.model.classDiagram.EVisibility;
	import de.waveumleditor.model.classDiagram.Type;
	import de.waveumleditor.model.classDiagram.Variable;
	import de.waveumleditor.model.wao.classDiagram.WAOClassAttribute;
	import de.waveumleditor.model.wao.wave.Delta;
	
	import flexunit.framework.TestCase;

	public class WAOClassAttributeTest extends TestCase
	{
		public function testStore():void
		{
			var delta:Delta = new Delta();
			
			var attribute:ClassAttribute = new ClassAttribute(new Identifier("attrId"), new Variable("a", Type.INT), EVisibility.PUBLIC);
			
			WAOClassAttribute.store(delta, "classId", attribute);
			
			assertEquals(delta.getWaveDelta()["classId_attrId"], "");
		}
	}
}