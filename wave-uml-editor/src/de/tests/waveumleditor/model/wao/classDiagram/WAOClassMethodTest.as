package de.tests.waveumleditor.model.wao.classDiagram
{
	import de.tests.TestUtil;
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.classDiagram.ClassMethod;
	import de.waveumleditor.model.classDiagram.EVisibility;
	import de.waveumleditor.model.classDiagram.Type;
	import de.waveumleditor.model.classDiagram.Variable;
	import de.waveumleditor.model.wao.classDiagram.WAOClassMethod;
	import de.waveumleditor.model.wao.classDiagram.WAOKeyGenerator;
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
		
			var value:String = delta.getWaveDelta()["classId" + WAOKeyGenerator.IDS_SEPERATOR + "mId"];
			
			assertNotNull(value);
			assertTrue(TestUtil.contains(value, "\"n\":\"doIt\""));
			assertTrue(TestUtil.contains(value, "\"t\":{\"n\":\"int\"}"));
			assertTrue(TestUtil.contains(value, "\"s\":false"));
			assertTrue(TestUtil.contains(value, "\"a\":false"));
		}
		
		public function testGetFromState():void
		{
			var methId:String = "M-methId";
			var classId:String = "C-classId";
			
			var m:ClassMethod = new ClassMethod(new Identifier(methId), "doIt", EVisibility.PUBLIC, Type.INT);
			m.addVariable(new Variable("a", Type.STRING));
			m.addVariable(new Variable("b", Type.INT, "0"));
			
			var delta:Delta = new Delta();
			WAOClassMethod.store(delta, classId, m);
			
			var key:String = classId + WAOKeyGenerator.IDS_SEPERATOR + methId;
			var json:String = delta.getWaveDelta()[key];
			
			var restoredMethod:ClassMethod = WAOClassMethod.getFromState(key, json);
			
			assertEquals(m.getIdentifier().getId(), restoredMethod.getIdentifier().getId());
			assertEquals(m.getVisibility().getValue(), restoredMethod.getVisibility().getValue());
			assertEquals(m.getVariables().length, restoredMethod.getVariables().length);
			assertEquals(m.getReturnType().getName(), restoredMethod.getReturnType().getName());
			assertEquals(m.isAbstract(), restoredMethod.isAbstract());
			assertEquals(m.isStatic(), restoredMethod.isStatic());
		}

	}
}