package de.tests.waveumleditor.model.wao.classDiagram
{
	import de.tests.TestUtil;
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.classDiagram.ClassMethod;
	import de.waveumleditor.model.classDiagram.EVisibility;
	import de.waveumleditor.model.classDiagram.Type;
	import de.waveumleditor.model.classDiagram.Variable;
	import de.waveumleditor.model.wao.classDiagram.WAOClassMethod;
	import de.waveumleditor.model.wao.wave.Delta;
	
	import flexunit.framework.TestCase;
	
	public class WAOClassMethodTest extends TestCase
	{
		public function testStore():void
		{
			var delta:Delta = new Delta();
			
			var m:ClassMethod = new ClassMethod(new Identifier("mId"), "doIt", EVisibility.PUBLIC, Type.INT);
			
			m.addVariable(new Variable("a", Type.STRING));
			m.addVariable(new Variable("b", Type.INT, "0"));
			
			WAOClassMethod.store(delta, "classId", m);
		
			var value:String = delta.getWaveDelta()["classId" + Delta.IDS_SEPERATOR + "mId"];
			
			assertNotNull(value);
			assertTrue(TestUtil.contains(value, "\"t\":{\"n\":\"int\"}"));
			assertTrue(TestUtil.contains(value, "\"s\":false"));
			assertTrue(TestUtil.contains(value, "\"a\":false"));
		}

	}
}