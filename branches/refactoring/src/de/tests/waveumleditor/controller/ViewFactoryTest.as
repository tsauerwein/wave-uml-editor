package de.tests.waveumleditor.controller
{
	import de.waveumleditor.controller.ViewFactory;
	import de.waveumleditor.model.Identifier;
	import de.waveumleditor.model.classDiagram.nodes.MClassNode;
	import de.waveumleditor.model.classDiagram.links.MAssociationLink;
	import de.waveumleditor.model.classDiagram.links.MImplementsLink;
	import de.waveumleditor.model.classDiagram.links.MInheritanceLink;
	import de.waveumleditor.view.diagrammer.classDiagram.links.VAssociationLink;
	import de.waveumleditor.view.diagrammer.classDiagram.nodes.VClassNode;
	import de.waveumleditor.view.diagrammer.classDiagram.links.VImplementsLink;
	import de.waveumleditor.view.diagrammer.classDiagram.links.VInheritanceLink;
	
	import flexunit.framework.TestCase;
	
	import org.flexunit.assertThat;
	
	public class ViewFactoryTest extends TestCase
	{
		public function testCreateNode():void
		{	
			assertThat(ViewFactory.createNode(new MClassNode(new Identifier("1234567"), null)) is VClassNode);
		}
		
		public function testCreateLink():void
		{	
			assertThat(ViewFactory.createLink(new MInheritanceLink(new Identifier("1234568"), null, null)) is VInheritanceLink);
			assertThat(ViewFactory.createLink(new MImplementsLink(new Identifier("12345681"), null, null)) is VImplementsLink);
			assertThat(ViewFactory.createLink(new MAssociationLink(new Identifier("12345682"), null, null)) is VAssociationLink);
		}

	}
}