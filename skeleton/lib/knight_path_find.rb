require_relative '00_tree_node'

class KnightPathFinder
  attr_reader :visited_pos
  DELTAS = [
    [-2, 1],
    [-2, -1],
    [-1, 2],
    [-1, -2],
    [1, 2],
    [2, -1],
    [2, 1],
    [1, -2]
  ]

  def initialize(start_pos)
    @start_pos = start_pos
    @visited_pos = [@start_pos]
    @move_tree = build_move_tree
  end

  def build_move_tree
    queue = [PolyTreeNode.new(@start_pos)]

    until queue.empty?
      current_node = queue.shift
      new_moves = new_move_positions(current_node.value)
      new_moves.each do |pos|
        new_node = PolyTreeNode.new(pos)
        new_node.parent = current_node
        queue << new_node
      end
    end
  end

  def self.valid_moves(pos)
    row, col = pos
    positions = []
    DELTAS.each do |delt_row, delt_col|
      positions << [row + delt_row, col + delt_col]
    end
    positions.select { |r, c| r.between?(0, 7) && c.between?(0, 7) }
  end

  def new_move_positions(pos)
    all_positions = KnightPathFinder.valid_moves(pos)
    new_positions = all_positions.reject do |move|
      @visited_pos.include?(move)
    end
    @visited_pos += new_positions
    new_positions
  end

end
