package com.signalsondisplay.clustr 
{
	/**
	 * ...
	 * @author dotminic
	 */
	public class ClustrAnalyser
	{
		private var m_grid:Grid;
		private var m_clusters:Vector.<Cluster>;
		private var m_cells:Vector.<GridCell>;
		private var m_resx:int;
		private var m_resy:int;
		private var m_width:int;
		private var m_height:int;
		private var m_clusterID:int;
		
		public function ClustrAnalyser( spaceWidth:int, spaceHeight:int )
		{
			m_width = spaceWidth;
			m_height = spaceHeight;
			m_clusters = new Vector.<Cluster>();
			m_grid = new Grid(m_width, m_height);
		}
	
		public function get clusters():Vector.<Cluster>
		{
			return m_clusters;
		}
		
		public function deleteClusters():void
		{
			for (var i:int = 0; i < m_clusters.length; i++)
				m_clusters[i].clear();
			m_clusters.length = 0;
		}
		
		public function addNode( x:Number, y:Number ):void
		{
			m_grid.addNode(new ClusterNode(x, y));
		}

		public function removeNodeAtPosition( x:Number, y:Number ):Boolean
		{
			return false;
		}

		public function clearAllNodes():void
		{
			m_grid.clear();
		}
		
		/**
		 * x/y resolution
		 * width/height of grid cell
		 *  
		 */
		public function run( rx:Number, ry:Number ):void
		{
			m_cells = m_grid.cells;
			m_clusters.length = 0;
			m_clusterID = 0;
			m_resx = rx;
			m_resy = ry;
			
			for (var y:int = 0; y < ry; y++)
			{
				for (var x:int = 0; x < rx; x++)
				{
					var index:int = y * rx + x;
					if (m_cells[index].size && !m_cells[index].visited)
					{
						m_clusters.push(new Cluster());
						m_cells[index].visited = true;
						scanNeighbours(x, y);
						m_clusterID++;
					}
				}
			}

			for (var i:int = 0; i < m_grid.cells.length; i++)
				m_grid.cells[i].reset();
		}
		
		private function scanNeighbours( x:int, y:int ):void
		{
			m_clusters[m_clusterID].addNodeList(m_cells[y * m_resx + x].nodes);

			// 1- check cell to the right
			var index:int = y * m_resx + (x + 1);
			if (x < (m_resx - 1) && !m_cells[index].visited)
			{
				m_cells[index].visited = true;
				if (m_cells[index].size)
					scanNeighbours(x + 1, y);
			}
			
			// 2- check cell to the bottom right
			index = (y + 1) * m_resx + (x + 1);
			if (x < (m_resx - 1) && y < (m_resy - 1) && !m_cells[index].visited)
			{
				m_cells[index].visited = true;
				if (m_cells[index].size)
					scanNeighbours(x + 1, y + 1);
			}
			
			// 3- check cell to the bottom
			index = (y + 1) * m_resx + x;
			if (y < (m_resy - 1) && !m_cells[index].visited)
			{
				m_cells[index].visited = true;
				if (m_cells[index].size)
					scanNeighbours(x, y + 1);
			}
			
			// 4- check cell to the bottom left
			index = (y + 1) * m_resx + (x - 1);
			if (x > 0 && y < (m_resy - 1) && !m_cells[index].visited)
			{
				m_cells[index].visited = true;
				if (m_cells[index].size)
					scanNeighbours(x - 1, y + 1);
			}
			
			// 5- check cell to the left
			index = y * m_resx + (x - 1);
			if (x > 0 && !m_cells[index].visited)
			{
				m_cells[index].visited = true;
				if (m_cells[index].size)
					scanNeighbours(x - 1, y);
			}
			
			// 6- check cell to the top left
			index = (y - 1) * m_resx + (x - 1);
			if (x > 0 && y > 0 && !m_cells[index].visited)
			{
				m_cells[index].visited = true;
				if (m_cells[index].size)
					scanNeighbours(x - 1, y - 1);
			}
			
			// 7- check cell to the top
			index = (y - 1) * m_resx + x;
			if (y > 0 && !m_cells[index].visited)
			{
				m_cells[index].visited = true;
				if (m_cells[index].size)
					scanNeighbours(x, y - 1);
			}
			
			// 8- check cell to the top right
			index = (y - 1) * m_resx + (x + 1);
			if (y > 0 && !m_cells[index].visited)
			{
				m_cells[index].visited = true;
				if (m_cells[index].size)
					scanNeighbours(x + 1, y - 1);
			}
		}	
	}
}