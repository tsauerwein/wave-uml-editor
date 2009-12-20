package de.tests.waveumleditor.model.wao.classDiagram
{
	import com.nextgenapp.wave.gadget.Wave;
	import com.nextgenapp.wave.gadget.WaveSimulator;
	
	import de.waveumleditor.controller.ModelFascade;
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.Position;
	import de.waveumleditor.model.classDiagram.ClassAttribute;
	import de.waveumleditor.model.classDiagram.ClassConstructorMethod;
	import de.waveumleditor.model.classDiagram.ClassDiagram;
	import de.waveumleditor.model.classDiagram.ClassMethod;
	import de.waveumleditor.model.classDiagram.EVisibility;
	import de.waveumleditor.model.classDiagram.Type;
	import de.waveumleditor.model.classDiagram.UMLClass;
	import de.waveumleditor.model.classDiagram.Variable;
	import de.waveumleditor.model.wao.classDiagram.WAODiagram;
	import de.waveumleditor.model.wao.classDiagram.WAONode;
	
	import flexunit.framework.TestCase;
	
	public class WAODiagramTest extends TestCase
	{
		public function testGetFromState():void
		{
			var wave:Wave = new WaveSimulator();
			var waoNode:WAONode = new WAONode(wave, null);
			
			var class1:UMLClass = new UMLClass(
				new Identifier(ModelFascade.PREFIX_NODE + "001"),
				new Position(1,2),
				"A");
			var class2:UMLClass = new UMLClass(
				new Identifier(ModelFascade.PREFIX_NODE + "002"),
				new Position(3,4),
				"B");
				
			waoNode.createNode(class1);
			waoNode.createNode(class2);
				
			var attribute1:ClassAttribute = new ClassAttribute(
				new Identifier(ModelFascade.PREFIX_ATTRIBUTE +  "001"),
				new Variable("a", Type.STRING),
				EVisibility.PUBLIC);
				
			var attribute2:ClassAttribute = new ClassAttribute(
				new Identifier(ModelFascade.PREFIX_ATTRIBUTE +  "002"),
				new Variable("b", Type.STRING),
				EVisibility.PUBLIC);
				
			var constructor1:ClassConstructorMethod = new ClassConstructorMethod(
				new Identifier(ModelFascade.PREFIX_CONSTRUCTOR + "001"),
				EVisibility.PUBLIC);
			class1.addConstructor(constructor1);	
				
			var method1:ClassMethod = new ClassMethod(
				new Identifier(ModelFascade.PREFIX_METHOD +  "001"),
				"doIt",
				EVisibility.PUBLIC,
				Type.BOOLEAN);	
			
			waoNode.updateClassAttribute(class1.getIdentifier(), attribute1);
			waoNode.updateClassConstructor(class1.getIdentifier(), constructor1);
			waoNode.updateClassAttribute(class2.getIdentifier(), attribute2);
			waoNode.updateClassMethod(class2.getIdentifier(), method1);
			
			var diagram:ClassDiagram = WAODiagram.getFromState(wave.getState());
			
			assertEquals(2, diagram.getNodes().length);
			
			var restoredClass1:UMLClass = diagram.getNode(class1.getIdentifier()) as UMLClass;
			var restoredClass2:UMLClass = diagram.getNode(class2.getIdentifier()) as UMLClass;
			
			assertEquals(1, restoredClass1.getAttributes().length);
			assertEquals(0, restoredClass1.getMethods().length);
			assertEquals(1, restoredClass1.getConstructors().length);
			assertEquals(1, restoredClass2.getAttributes().length);
			assertEquals(1, restoredClass2.getMethods().length);
			assertEquals(0, restoredClass2.getConstructors().length);
		
		}

	}
}