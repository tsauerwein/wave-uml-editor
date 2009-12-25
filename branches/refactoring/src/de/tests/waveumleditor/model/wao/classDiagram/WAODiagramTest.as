package de.tests.waveumleditor.model.wao.classDiagram
{
	import com.nextgenapp.wave.gadget.Wave;
	import com.nextgenapp.wave.gadget.WaveSimulator;
	
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.Position;
	import de.waveumleditor.model.classDiagram.nodes.MClassAttribute;
	import de.waveumleditor.model.classDiagram.nodes.MClassConstructorMethod;
	import de.waveumleditor.model.classDiagram.MClassDiagram;
	import de.waveumleditor.model.classDiagram.nodes.MClassMethod;
	import de.waveumleditor.model.classDiagram.nodes.EVisibility;
	import de.waveumleditor.model.classDiagram.nodes.MType;
	import de.waveumleditor.model.classDiagram.nodes.MClassNode;
	import de.waveumleditor.model.classDiagram.nodes.MVariable;
	import de.waveumleditor.model.classDiagram.links.MAssociationLink;
	import de.waveumleditor.model.classDiagram.links.MInheritanceLink;
	import de.waveumleditor.model.wao.classDiagram.WAODiagram;
	import de.waveumleditor.model.wao.classDiagram.WAOKeyGenerator;
	import de.waveumleditor.model.wao.classDiagram.WAOLink;
	import de.waveumleditor.model.wao.classDiagram.WAONode;
	
	import flexunit.framework.TestCase;
	
	public class WAODiagramTest extends TestCase
	{
		public function testGetFromState():void
		{
			var wave:Wave = new WaveSimulator();
			var waoLink:WAOLink = new WAOLink(wave);
			var waoNode:WAONode = new WAONode(wave, waoLink);
			
			
			var class1:MClassNode = new MClassNode(
				new Identifier(WAOKeyGenerator.PREFIX_NODE + "001"),
				new Position(1,2),
				"A");
			var class2:MClassNode = new MClassNode(
				new Identifier(WAOKeyGenerator.PREFIX_NODE + "002"),
				new Position(3,4),
				"B");
				
			waoNode.createNode(class1);
			waoNode.createNode(class2);
				
			var attribute1:MClassAttribute = new MClassAttribute(
				new Identifier(WAOKeyGenerator.PREFIX_ATTRIBUTE +  "001"),
				new MVariable("a", MType.STRING),
				EVisibility.PUBLIC);
				
			var attribute2:MClassAttribute = new MClassAttribute(
				new Identifier(WAOKeyGenerator.PREFIX_ATTRIBUTE +  "002"),
				new MVariable("b", MType.STRING),
				EVisibility.PUBLIC);
				
			var constructor1:MClassConstructorMethod = new MClassConstructorMethod(
				new Identifier(WAOKeyGenerator.PREFIX_CONSTRUCTOR + "001"),
				EVisibility.PUBLIC);
			class1.addConstructor(constructor1);	
				
			var method1:MClassMethod = new MClassMethod(
				new Identifier(WAOKeyGenerator.PREFIX_METHOD +  "001"),
				"doIt",
				EVisibility.PUBLIC,
				MType.BOOLEAN);	
			
			waoNode.updateClassAttribute(class1.getIdentifier(), attribute1);
			waoNode.updateClassConstructor(class1.getIdentifier(), constructor1);
			waoNode.updateClassAttribute(class2.getIdentifier(), attribute2);
			waoNode.updateClassMethod(class2.getIdentifier(), method1);
			
			var link1:MInheritanceLink = new MInheritanceLink(
				new Identifier(WAOKeyGenerator.PREFIX_LINK + "001"),
				class1,
				class2);
			var link2:MAssociationLink = new MAssociationLink(
				new Identifier(WAOKeyGenerator.PREFIX_LINK + "002"),
				class2,
				class1);
			link2.setName("Test");
			link2.setFromMultiplicity("1");
			
			waoLink.createLink(link1);
			waoLink.createLink(link2);
			waoLink.updateLink(link2);	
			
			var diagram:MClassDiagram = WAODiagram.getFromState(wave.getState());
			
			assertEquals(2, diagram.getNodes().length);
			
			var restoredClass1:MClassNode = diagram.getNode(class1.getIdentifier()) as MClassNode;
			var restoredClass2:MClassNode = diagram.getNode(class2.getIdentifier()) as MClassNode;
			
			assertEquals(1, restoredClass1.getAttributes().length);
			assertEquals(0, restoredClass1.getMethods().length);
			assertEquals(1, restoredClass1.getConstructors().length);
			assertEquals(1, restoredClass2.getAttributes().length);
			assertEquals(1, restoredClass2.getMethods().length);
			assertEquals(0, restoredClass2.getConstructors().length);
			
			assertEquals(2, diagram.getLinks().length);
			
			var restoredLink1:MInheritanceLink = diagram.getLink(link1.getIdentifier()) as MInheritanceLink;
			var restoredLink2:MAssociationLink = diagram.getLink(link2.getIdentifier()) as MAssociationLink;
			
			assertEquals(link1.getLinkFrom().getIdentifier().getId(),
				restoredLink1.getLinkFrom().getIdentifier().getId());
			assertEquals(link2.getName(), restoredLink2.getName());
			assertEquals(link2.getFromMultiplicity(), restoredLink2.getFromMultiplicity());
		}

	}
}