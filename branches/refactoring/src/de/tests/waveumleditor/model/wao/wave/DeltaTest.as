package de.tests.waveumleditor.model.wao.wave
{
	import de.tests.TestUtil;
	import de.waveumleditor.model.wao.wave.Delta;
	
	import flexunit.framework.TestCase;

	public class DeltaTest extends TestCase
	{
		
		
		public function testToString():void
		{
			var delta:Delta = new Delta();
			
			delta.setValue("key1", "value1");
			delta.setValue("key2", "value2");
			
			assertTrue(TestUtil.contains(delta.toString(), "key2 : value2"));
			assertTrue(TestUtil.contains(delta.toString(), "key1 : value1"));
		}
	}
}