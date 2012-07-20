package  
{
	import flash.display.*;
	import com.bit101.components.PushButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author dotminic
	 */
	public class View extends Sprite 
	{
		private static const WIDTH:int = 1280;
		private static const HEIGHT:int = 720;
		private static const DASHBOARD_HEIGHT:int = 48;
		
		// dashboard
		private var m_runButton:PushButton;
		private var m_resButton:PushButton;
		private var m_gridToggle:PushButton;
		private var m_overlayToggle:PushButton;
		private var m_clearButton:PushButton;
		private var m_gridVisible:Boolean;
		private var m_overlayVisible:Boolean;
		
		// visualizer
		private var m_bitmap:Bitmap;
		private var m_bitmapData:BitmapData;
		//private var m_grid:Grid;
		private var m_cells:Vector.<uint>;
		private var m_grid:Sprite;
		private var m_overlay:Sprite;
		private var m_resx:int;
		private var m_resy:int;

		public function View() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
			m_resx = 16;
			m_resy = 16;
		}
		
		private function init( e:Event ):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);

			m_runButton = new PushButton(dashboard, 0, 0, "run", runBtnHandler);
			var yPos:int = (dashboard.height / 2) - m_runButton.height / 2;
			m_runButton.x = m_runButton.y = yPos;
			
			m_resButton = new PushButton(dashboard, yPos + m_runButton.width + 20, yPos, "set resolution", setResolutionHandler);
			m_clearButton = new PushButton(dashboard, m_resButton.x + m_resButton.width + 20, yPos, "clear nodes", clearNodesHandler);
			m_gridToggle = new PushButton(dashboard, m_clearButton.x + m_clearButton.width + 20, yPos, "hide grid", gridToggleHandler);
			m_overlayToggle = new PushButton(dashboard, m_gridToggle.x + m_gridToggle.width + 20, yPos, "hide overlay", overlayToggleHandler);

			m_bitmapData = new BitmapData(WIDTH, HEIGHT, false, 0x0);
			m_bitmap = new Bitmap(m_bitmapData);
			m_bitmap.y = DASHBOARD_HEIGHT;
			addChild(m_bitmap);

			m_grid = new Sprite();
			m_grid.y = DASHBOARD_HEIGHT;
			m_grid.mouseEnabled = false;
			addChild(m_grid);
			drawGrid();

			m_overlay = new Sprite();
			m_overlay.y = DASHBOARD_HEIGHT;
			addChild(m_overlay);

			dashboard.resx_txt.text = "res x: " + String(m_resx);
			dashboard.resy_txt.text = "res y: " + String(m_resy);
			dashboard.nodes_txt.text = "nodes: 0";
			dashboard.clusters_txt.text = "clusters: 0";
			
			addChild(popup);
			popup.addEventListener(ResolutionEvent.CHANGED, resChangesHandler);
			popup.visible = false;

			m_cells = new Vector.<uint>(m_resx * m_resy);

			addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
			addEventListener(MouseEvent.CLICK, clickHandler);
		}
		
		private function mouseMoveHandler( e:MouseEvent ):void
		{
			var x:int = m_bitmap.mouseX;
			var y:int = m_bitmap.mouseY;

			if (x < 0 || y < 0)
				x = y = 0;
			dashboard.mousex_txt.text = "x: " + String(x);
			dashboard.mousey_txt.text = "y: " + String(y);
		}
		
		private function runBtnHandler( e:MouseEvent ):void
		{
			//dispatchEvent(new Event(Event.SELECT));
		}
		
		private function setResolutionHandler( e:MouseEvent ):void
		{
			popup.visible = true;
		}
		
		private function resChangesHandler( e:ResolutionEvent ):void
		{
			m_resx = e.resx;
			m_resy = e.resy;
			m_cells = new Vector.<uint>(m_resx * m_resy);
			m_overlay.graphics.clear();
			drawGrid();
		}
		
		private function gridToggleHandler( e:MouseEvent ):void
		{
			m_grid.visible = !m_grid.visible;
		}
		
		private function overlayToggleHandler( e:MouseEvent ):void
		{
			m_overlay.visible = !m_overlay.visible;
		}
		
		private function clearNodesHandler( e:MouseEvent ):void
		{
			dispatchEvent(new Event(Event.CLEAR));
		}
		
		private function clickHandler( e:MouseEvent ):void
		{
			e.stopImmediatePropagation();
			if (m_bitmap.mouseX >= 0 && m_bitmap.mouseY >= 0)
			{
				m_bitmapData.setPixel(m_bitmap.mouseX, m_bitmap.mouseY, 0xFFFFFF);
				highlightCell();
			}
		}
		
		private function drawGrid():void
		{
			var sx:int = WIDTH / m_resx;
			var sy:int = HEIGHT / m_resy;
			
			m_grid.graphics.clear();
			m_grid.graphics.lineStyle(1, 0xCCCCCC, .25);
			for (var i:int = 1; i < m_resx; i++)
			{
				m_grid.graphics.moveTo(i * sx, 0);
				m_grid.graphics.lineTo(i * sx, HEIGHT);
			}
			for (var j:int = 1; j < m_resy; j++)
			{
				m_grid.graphics.moveTo(0, j * sy);
				m_grid.graphics.lineTo(WIDTH, j * sy);
			}
		}
		
		private function highlightCell():void
		{
			var x:int = m_bitmap.mouseX / WIDTH * m_resx;
			var y:int = m_bitmap.mouseY / HEIGHT * m_resy;
			trace(y * m_resx + x, x, y);
			m_cells[y * m_resx + x]++;
			if (m_cells[y * m_resx + x] < 4)
			{
				m_overlay.graphics.beginFill(0xFF0000, .16);
				m_overlay.graphics.drawRect(x * WIDTH / m_resx + 1, y * HEIGHT / m_resy + 1, WIDTH / m_resx - 1, HEIGHT / m_resy - 1);
				m_overlay.graphics.endFill();
			}
		}
		
	}

}