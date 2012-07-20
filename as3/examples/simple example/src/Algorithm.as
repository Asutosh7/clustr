package  
{
	/**
	 * ...
	 * @author dotminic
	 */
	public class Algorithm
	{
		private var m_clusters:Vector.<Cluster>;
		private var m_cells:Vector.<GridCell>;
		private var m_resx:Number;
		private var m_resy:Number;
		private var m_clusterID:int;
		
		public function Algorithm()
		{
			m_clusters = new Vector.<Cluster>();
		}
	
		public function get clusters():Vector.<Cluster>
		{
			return m_clusters;
		}
		
		/**
		 * x/y resolution
		 * width/height of grid cell
		 * 
		 */
		public function run( nodes:Vector.<GridCell>, rx:Number, ry:Number ):void
		{
			m_cells = nodes;
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