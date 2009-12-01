package com.anotherflexdev.diagrammer {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.ui.Keyboard;
	
	import mx.binding.utils.BindingUtils;
	import mx.collections.ArrayCollection;
	import mx.containers.Canvas;
	import mx.controls.Image;
	import mx.controls.Text;
	import mx.controls.TextInput;
	import mx.core.DragSource;
	import mx.core.IFactory;
	import mx.core.UIComponent;
	import mx.events.MoveEvent;
	import mx.events.ResizeEvent;
	import mx.managers.DragManager;
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.StyleManager;



	[Style(name="linkingGlowColor", type="uint", format="Color")]
	[Style(name="labelFontFamily", type="String")]
	[Style(name="labelFontSize", type="String")]
	[Style(name="labelFontColor", type="uint", format="Color")]
	public class BaseNode extends Canvas implements DiagramElement {
		
		[Bindable] public var textMargin:Number = 1;
		[Bindable] public var nodeName:String = "No Name";
		[Bindable] public var editable:Boolean = true;
		public var customLink:IFactory;
		
		protected var lblNodeName:Text;
		protected var nodeContextPanel:GenericNodeContextPanel;
		
		protected var txNodeName:TextInput;
		private var linkingGlowFilter:GlowFilter;
		private var arrivingLinks:ArrayCollection;
		private var leavingLinks:ArrayCollection;
		
        private static var classConstructed:Boolean = classConstruct();
        
        private static function classConstruct():Boolean {
            if (!StyleManager.getStyleDeclaration("BaseNode")) {
                var defaultLinkStyles:CSSStyleDeclaration = new CSSStyleDeclaration();
                defaultLinkStyles.defaultFactory = function():void {
					this.linkingGlowColor = 0xFFFFFF;
					this.labelFontFamily = "Verdana";
					this.labelFontColor = 0xa0a0a0;
					this.labelFontSize = 12;
					this.labelFontWeight = "regular";
                }
                StyleManager.setStyleDeclaration("BaseNode", defaultLinkStyles, true);
            }
            return true;
        }		
		
		public function BaseNode() {
			super();
			this.clipContent = false;
			this.addEventListener(MouseEvent.MOUSE_MOVE, handleMouseMove);
			this.addEventListener(MouseEvent.ROLL_OVER, handleMouseRollOver);
			this.addEventListener(MouseEvent.ROLL_OUT, handleMouseRollOut);
			this.addEventListener(MoveEvent.MOVE, handleMove);			
			this.addEventListener(ResizeEvent.RESIZE, handleResize);			
			this.arrivingLinks = new ArrayCollection;
			this.leavingLinks = new ArrayCollection;
			this.minWidth = 100;
		}
		
		override protected function createChildren():void {
			super.createChildren();
			if(!this.lblNodeName) {
				this.lblNodeName = new Text;
				BindingUtils.bindProperty(this.lblNodeName, "text", this, "nodeName");
				this.lblNodeName.setStyle("verticalCenter", 0);
				this.lblNodeName.selectable = false;
				this.lblNodeName.setStyle("textAlign","center"); 
				this.lblNodeName.setStyle("fontWeight","bold");
			}
			this.addChild(this.lblNodeName);
			this.lblNodeName.addEventListener(MouseEvent.CLICK, handleLblNodeNameClick);
			if(!this.txNodeName) {
				this.txNodeName = new TextInput;
				this.txNodeName.maxWidth = 150;
				this.txNodeName.setStyle("horizontalCenter", 0);
			}
			this.txNodeName.addEventListener(KeyboardEvent.KEY_UP, handleTxNodeNameKeyUp);
			if(!this.nodeContextPanel) {
				createNodeContextPanel();
				
				this.nodeContextPanel.addEventListener(MouseEvent.ROLL_OVER, handleMouseRollOver);
				this.nodeContextPanel.addEventListener(MouseEvent.ROLL_OUT, handleMouseRollOut);
				this.nodeContextPanel.addEventListener("removeNode", handleRemoveNode);
			}
			if(!this.linkingGlowFilter){
				this.linkingGlowFilter = new GlowFilter;
				this.linkingGlowFilter.blurX = 12; 
				this.linkingGlowFilter.blurY = 9;
			}
		}
		
		protected function createNodeContextPanel():void {
			this.nodeContextPanel = new NodeContextPanel;
			this.nodeContextPanel.addEventListener("linkNode", handleLinkNode);	
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
			this.lblNodeName.x = this.textMargin;
			this.lblNodeName.width = this.width - this.textMargin * 2;
			this.lblNodeName.setStyle("fontFamily", this.getStyle("labelFontFamily"));
			this.lblNodeName.setStyle("fontSize", this.getStyle("labelFontSize"));
			this.lblNodeName.setStyle("color",this.getStyle("labelFontColor"));
			this.lblNodeName.setStyle("fontWeight",this.getStyle("labelFontWeight"));
			this.txNodeName.y = this.lblNodeName.y; 
			
			this.linkingGlowFilter.color = this.getStyle("linkingGlowColor");
			//Draw a trasparent rectangle for correct behavior of roll_over event
			this.graphics.beginFill(0xFFFFFF, 0.0);
			this.graphics.drawRect(0, 0, this.width, this.height);
			super.updateDisplayList(unscaledWidth, unscaledHeight);
		}
		
		private function handleRemoveNode(event:Event):void {
			var diagram:Diagram = Diagram(parent);
			if(diagram.contains(this.nodeContextPanel)) {
				this.nodeContextPanel.removeEventListener(MouseEvent.ROLL_OUT, handleMouseRollOut);
				diagram.removeChild(this.nodeContextPanel);
			}
			diagram.removeNode(this);
		}
		
		protected function handleLinkNode(event:MouseEvent):void {
			Diagram(parent).beginLink(this);
		}

		protected function handleCustomLinkNode(event:BeginLinkEvent):void {
			Diagram(parent).beginLink(this, event.getLinkFactory());
		}		

		private function handleMove(event:MoveEvent):void {
			redrawLinks();
		}
		
		private function redrawLinks():void {
			for each(var arrivingLink:Link in this.arrivingLinks) {
				arrivingLink.invalidateDisplayList();
			}
			for each(var leavingLink:Link in this.leavingLinks) {
				leavingLink.invalidateDisplayList();
			}
		}
		
		private function handleMouseClick(event:MouseEvent):void {
			if(Diagram(parent).isLinking) {
				this.filters = null;
				this.removeEventListener(MouseEvent.CLICK, handleMouseClick);
				Diagram(parent).endLink();
			}
		}
		
		private function handleMouseMove(event:MouseEvent):void {
			if(!DragManager.isDragging && event.buttonDown) {
				doDrag(event);
			}
		}
		
		private function doDrag(event:MouseEvent):void {
			this.currentState = null;
			var initiator:UIComponent = this;
			var dragImg:Image = new Image();  
			
			var UIBData:BitmapData = new BitmapData(this.width, this.height, true, 0xFFFFFF);
			var UIMatrix:Matrix = new Matrix();
			UIBData.draw(this, UIMatrix);  
			dragImg.source = new Bitmap(UIBData);  
			  
			var dsource:DragSource = new DragSource();
			dsource.addData(this, 'node');
			dsource.addData(this.mouseX, 'mouseX');
			dsource.addData(this.mouseY, 'mouseY');
			parent.addChild(dragImg);
			DragManager.doDrag(initiator, dsource, event, dragImg);
		}	
		
		private function handleResize(event:ResizeEvent):void {
			this.nodeContextPanel.y = this.y + ((this.height / 2) - (this.nodeContextPanel.height / 2));
			this.nodeContextPanel.x = this.x + (this.width - 10);
			this.redrawLinks();
		}
					
		private function handleMouseRollOver(event:MouseEvent):void {
			if(!Diagram(parent).contains(this.nodeContextPanel) && !Diagram(parent).isLinking) {
				this.nodeContextPanel.y = this.y + ((this.height / 2) - (this.nodeContextPanel.height / 2));
				this.nodeContextPanel.x = this.x + (this.width - 10);
				Diagram(parent).addChild(this.nodeContextPanel);
			}
			if(Diagram(parent).isLinking && Diagram(parent).isValidLink(this)) {
				this.filters = [this.linkingGlowFilter];
				this.addEventListener(MouseEvent.CLICK, handleMouseClick);
			}
		}
		
		public function cancelLinking():void {
				this.filters = null;
				this.removeEventListener(MouseEvent.CLICK, handleMouseClick);
		}
		
		private function handleMouseRollOut(event:MouseEvent):void {
			if(Diagram(parent).contains(this.nodeContextPanel)) {
				Diagram(parent).removeChild(this.nodeContextPanel);
			}
			if(Diagram(parent).isLinking) {
				cancelLinking();
			}
		}			
			
		private function editNodeName():void {
			this.txNodeName.text = this.nodeName;
			this.removeChild(this.lblNodeName);
			this.addChild(this.txNodeName);
			this.txNodeName.selectionBeginIndex = 0;
			this.txNodeName.selectionEndIndex = this.nodeName.length;
			this.txNodeName.setFocus();				
		}
		
		private function unEditNodeName():void {
			this.removeChild(this.txNodeName);
			this.addChild(this.lblNodeName);
		}
		
		private function handleTxNodeNameKeyUp(event:KeyboardEvent):void {
			if(event.keyCode == Keyboard.ENTER) {
				this.nodeName = this.txNodeName.text;
				unEditNodeName();
			} else if(event.keyCode == Keyboard.ESCAPE) {
				unEditNodeName();
			}
		}
		
		private function handleLblNodeNameClick(event:MouseEvent):void {
			if(!Diagram(parent).isLinking && this.editable) {
				this.editNodeName();
			}
		}
		
		public function addArrivingLink(link:Link):void {
			this.arrivingLinks.addItem(link);
		}

		public function addLeavingLink(link:Link):void {
			this.leavingLinks.addItem(link);
		}
		
		public function removeLink(link:Link):void {
			if(this.arrivingLinks.contains(link)) {
				this.arrivingLinks.removeItemAt(this.arrivingLinks.getItemIndex(link));
			}
			if(this.leavingLinks.contains(link)){
				this.leavingLinks.removeItemAt(this.leavingLinks.getItemIndex(link));
			}
		}
		
		public function getAllLinks():ArrayCollection {
			var result:ArrayCollection = new ArrayCollection;
			for each(var arrivingLink:Link in this.arrivingLinks) {
				result.addItem(arrivingLink);
			}
			for each(var leavingLink:Link in this.leavingLinks) {
				result.addItem(leavingLink);
			}			
			return result;
		}

	}
}