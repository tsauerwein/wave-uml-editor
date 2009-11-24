package de.tests.waveumleditor.controller
{
	import de.waveumleditor.controller.ViewFactory;
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
			assertThat(ViewFactory.createNode(new UMLClass(null)) is ClassNode);
		}
		
		public function testCreateLink():void
		{	
			assertThat(ViewFactory.createLink(new LinkInheritance(null, null)) is InheritanceLink);
			assertThat(ViewFactory.createLink(new LinkImplements(null, null)) is ImplementsLink);
			assertThat(ViewFactory.createLink(new LinkAssociation(null, null)) is AssociationLink);
		}

	}
}