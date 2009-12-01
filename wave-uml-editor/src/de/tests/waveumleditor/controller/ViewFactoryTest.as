package de.tests.waveumleditor.controller
{
	import de.waveumleditor.controller.ViewFactory;
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.classDiagram.UMLClass;
	import de.waveumleditor.model.classDiagram.link.LinkAssociation;
	import de.waveumleditor.model.classDiagram.link.LinkImplements;
	import de.waveumleditor.model.classDiagram.link.LinkInheritance;
	import de.waveumleditor.view.diagrammer.classDiagram.AssociationLink;
	import de.waveumleditor.view.diagrammer.classDiagram.ClassNode;
	import de.waveumleditor.view.diagrammer.classDiagram.ImplementsLink;
	import de.waveumleditor.view.diagrammer.classDiagram.InheritanceLink;
	
	import flexunit.framework.TestCase;
	
	import org.flexunit.assertThat;
	
	public class ViewFactoryTest extends TestCase
	{
		public function testCreateNode():void
		{	
			assertThat(ViewFactory.createNode(new UMLClass(new Identifier("1234567"), null)) is ClassNode);
		}
		
		public function testCreateLink():void
		{	
			assertThat(ViewFactory.createLink(new LinkInheritance(new Identifier("1234568"), null, null)) is InheritanceLink);
			assertThat(ViewFactory.createLink(new LinkImplements(new Identifier("12345681"), null, null)) is ImplementsLink);
			assertThat(ViewFactory.createLink(new LinkAssociation(new Identifier("12345682"), null, null)) is AssociationLink);
		}

	}
}