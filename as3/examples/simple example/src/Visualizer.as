package  
{
	import flash.display.*;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author dotminic
	 */
	public class Visualizer extends Sprite
	{
		private static const WIDTH:int = 1280;
		private static const HEIGHT:int = 720;
		
		private var m_bitmap:Bitmap;
		private var m_bitmapData:BitmapData;
		private var m_grid:Grid;
		private var m_overlay:Sprite;
		
		public function Visualizer()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init( e:Event ):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			m_bitmapData = new BitmapData(WIDTH, HEIGHT, false, 0x0);
			m_bitmap = new Bitmap(m_bitmapData);
			addChild(m_bitmap);
			
			m_grid = new Grid();
			addChild(m_grid);
			m_grid.draw();
			
			m_overlay = new Sprite();
			addChild(m_overlay);
			
			addEventListener(MouseEvent.CLICK, clickHandler);
		}

		public function get grid():Grid
		{
			return m_grid;
		}
		
		public function displayClusters( clusters:Vector.<Cluster> ):void
		{
			m_overlay.visible = false;
			m_grid.visible = false;
			
			trace("num clusters: " + clusters.length);
			
			var colors:Array = [0x00FF00, 0xFF00FF];
			
			for (var i:int = 0; i < clusters.length; i++)
			{
				trace("num nodes: " + clusters[i].nodes.length);
				var color:uint = Math.random() * 0xFFFFFF;
				for (var j:int = 0; j < clusters[i].nodes.length; j++)
				{
					m_bitmapData.setPixel
					(
						clusters[i].nodes[j].x,
						clusters[i].nodes[j].y,
						colors[i]
					);
				}
			}
		}

		public function toggleGrid( visible:Boolean ):void
		{
			m_grid.visible = visible;
		}
		
		public function toggleOverlay( visible:Boolean ):void
		{
			m_overlay.visible = visible;
		}
		
		private function clickHandler( e:MouseEvent ):void
		{
			e.stopImmediatePropagation();
			m_bitmapData.setPixel(e.localX, e.localY, 0xFFFFFF);
			m_grid.addNode(new ClusterNode(e.localX, e.localY));
		}
	}
}