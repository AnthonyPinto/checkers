class Piece
  attr_reader :color, :diffs
  
  DIFFS = {
    black: [[1,-1], [1, 1]], 
    red: [[-1, 1], [-1, -1]] 
  }
  
  def initialize(board, color, pos)
    @board, @color, @pos = board, color, pos
    @king = false
    @diffs = DIFFS[@color]
  end
  
  def to_s
    @color == :red ? 'Red' : 'Blk'
  end
  
  def inspect
    "#{self.class},#{@color} #{@pos} @king = #{@king}"
  end
  
  def perform_step(pos)
    return false unless legal_steps.include?(pos)
    change_pos(pos)
  end
  
  def perform_jump(pos)
    return false unless legal_jumps_with_captures.include?(pos)
    @board[legal_jumps_with_captures[pos]] = nil #remove captured piece
    change_pos(pos)
  end
  
  def capture(new_pos)
    
  end
  
  def change_pos(new_pos)
    @board[@pos], @board[new_pos] = nil, self
    @pos = new_pos
  end
  
  def legal_steps
    p self
    p legal_diffs
    legal_diffs[:step].map { |diff| relative_pos(diff) }
  end
  
  def legal_jumps_with_captures
    jumps = {}
    legal_diffs[:jump].each do |diff| 
      enemy = relative_pos(diff)
      landing_space = relative_pos([diff[0]*2, diff[1]*2])
      jumps[landing_space] = enemy
    end
    jumps
  end
      
  
  def legal_diffs
    new_diffs = { step: [], jump: [], illegal: [] }
    @diffs.each do |diff|
      new_diffs[step_or_jump(diff)] << diff
    end
    new_diffs
  end
  
      
  def step_or_jump(diff)
    pos = relative_pos(diff)
    return :illegal unless @board.on_board?(pos)
    return :step if @board[pos].nil? 
    return :jump unless @board[pos].color == @color
    return :illegal
  end
  
  def relative_pos(diff)
    p @diffs
    p diff
    [diff.first + @pos.first, diff.last + @pos.last]
  end
  
end