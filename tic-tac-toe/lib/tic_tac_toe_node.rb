require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
    @root =
    @parent = nil
  end

  def losing_node?(evaluator)
  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children_arr = []
    empty_pos = []
    @board.rows.each_index do |i|
      @board.rows[i].each_index do |j|
        pos = [i, j]
        empty_pos << [i, j] if @board.empty?(pos)
      end
    end

    switch_mark

    duped_board = @board.dup
    empty_pos.each do |pos|
      duped_board[pos] = @next_mover_mark
      @prev_mov_pos = pos
      children_arr << TicTacToeNode.new(duped_board, @next_mover_mark, @prev_mov_pos)
    end

    children_arr

  end

  def switch_mark
    @next_mover_mark = (@next_mover_mark == :x ? :o : :x)
  end

  

end
