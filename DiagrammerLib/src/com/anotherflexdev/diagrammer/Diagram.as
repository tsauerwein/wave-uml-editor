package com.anotherflexdev.diagrammer {
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.containers.Canvas;
	import mx.core.IFactory;
	import mx.core.UIComponent;
	import mx.events.DragEvent;
	import mx.managers.DragManager;

	public class Diagram extends Canvas {
		
		private var templateLine:Link;
		private var currentLinkFactory:IFactory;
		
		public function Diagram() {
			super();
			this.addEventListener(DragEvent.DRAG_ENTER, handleDragEnter);
			this.addEventListener(DragEvent.DRAG_DROP, handleDragDrop);
			this.addEventListener(MouseEvent.MOUSE_MOVE, handleMouseMove);
			this.addEventListener(Event.ADDED, handleAdded);
			this.addEventListener(Event.REMOVED, handleRemoved);
		}
		
		public function get isLinking():Boolean {
			return this.templateLine.fromNode != null;
		}
		
		override protected function createChildren():void {
			if(!this.templateLine) {
				this.templateLine = new Link;
			}
			super.createChildren();
		}
		
		private function handleAdded(event:Event):void {
			if(event.target is BaseNode) {
				var node:BaseNode = BaseNode(event.target);
				node.addEventListener(MouseEvent.ROLL_OVER, handleNodeRollOver);
				node.addEventListener(MouseEvent.ROLL_OUT, handleNodeRollOut);
			}
		}
		
		private function handleRemoved(event:Event):void {
			if(event.target is BaseNode) {
				var node:BaseNode = BaseNode(event.target);
				node.removeEventListener(MouseEvent.ROLL_OVER, handleNodeRollOver);
				node.removeEventListener(MouseEvent.ROLL_OUT, handleNodeRollOut);
			}
		}
		
		private function handleNodeRollOver(event:MouseEvent):void {
			if(this.isLinking) {
				this.templateLine.toNode = BaseNode(event.currentTarget);
			}
		}
		
		private function handleNodeRollOut(event:MouseEvent):void {
			if(this.isLinking) {
				this.templateLine.toNode = null;
			}
		}
		
		private function handleDragDrop(event:DragEvent):void {
			var node:BaseNode = event.dragSource.dataForFormat("node") as BaseNode;
			node.x = event.stageX - Number(event.dragSource.dataForFormat("mouseX"));
			node.y = event.stageY - Number(event.dragSource.dataForFormat("mouseY"));			
		}
		
		private function handleDragEnter(event:DragEvent):void {
		  	DragManager.acceptDragDrop(UIComponent(event.currentTarget));			
		}		
		
		private function handleMouseMove(event:MouseEvent):void {
			if(this.isLinking) {
				this.templateLine.invalidateDisplayList();
			}
		}
		
		public function beginLink(fromNode:BaseNode, linkFactory:IFactory = null):void {
			this.currentLinkFactory = linkFactory;
			if (linkFactory != null) {
				this.templateLine = linkFactory.newInstance();
			} else {
				this.templateLine = new Link;
			}
			
			this.templateLine.fromNode = fromNode;
			this.addChild(this.templateLine);
		}
		
		public function endLink():void {
			this.removeChild(this.templateLine);
			this.addLink(this.templateLine.fromNode, this.templateLine.toNode);
			this.templateLine.fromNode = null;
			this.templateLine.toNode = null;
		}
		
		public function addLink(fromNode:BaseNode, toNode:BaseNode):void {
			var link:Link = null;
			if (currentLinkFactory != null) {
				link = currentLinkFactory.newInstance();
			} else if(toNode.customLink != null) {
				link = toNode.customLink.newInstance();
			} else {
				link = new Link;
			}
			link.fromNode = fromNode;
			link.toNode = toNode;
			fromNode.addLeavingLink(link);
			toNode.addArrivingLink(link);
			this.addChildAt(link, 0);
		}
		
		public function removeNode(node:BaseNode):void {
			this.removeChild(node);
			var nodeLinks:ArrayCollection = node.getAllLinks();
			for each(var nodeLink:Link in nodeLinks){
				if(this.contains(nodeLink)){
					this.removeChild(nodeLink);
				}
				nodeLink.fromNode.removeLink(nodeLink);
			}
		}
				
		public function removeLink(link:Link):void {
			this.removeChild(link);
			link.fromNode.removeLink(link);
			link.toNode.removeLink(link);
		}		
		
	}
}