load "./piece.rb"

class Board
  
  attr_accessor :matrix
  
  def initialize start = true
    @rows = Array.new(8) {Array.new(8)}
    set_pieces if start
  end
  
  def [] pos
    @rows[pos[0]][pos[1]]
  end
  
  def []= pos, val
    @rows[pos[0]][pos[1]] = val
  end
  
  def dup
    new_board = Board.new false
    @rows.each_with_index do |row, x|
      row.each_with_index do |piece, y|
        new_board[[x, y]] = piece.dup(new_board) if piece
      end
    end
    new_board
  end
  
  def on_board?(pos)
    (0..7).cover?(pos[0]) && (0..7).cover?(pos[1])
  end
  
  def all_steps
    steps = []
    @rows.each do |row|
      row.each do |space|
        steps << space.legal_steps if space
      end
    end
    steps
  end
  
  def display
    puts '-'*32
    @rows.each do |row| 
      row.each do |space|
        unless space
          print '|   '
          next
        end
        print "|#{space}"
      end
      print '|'
      puts
      puts '-'*32
    end 
  end
  
  def set_pieces
    pieces = {
      red: [[0,1], [0,3], [0,5], [0,7],
      [1,0], [1,2], [1,4], [1,6],
      [2,1], [2,3], [2,5], [2,7]],

      black: [[5,0], [5,2], [5,4], [5,6],
        [6,1], [6,3], [6,5], [6,7],
        [7,0], [7,2], [7,4], [7,6]]
    }
    
    # pieces = {
    #   black: [[2,4]],
    #
    #   red: [[3,3], [5,1]]
    # }
    pieces.each do |color, positions|
      positions.each {|pos| place_piece(color, pos)}
    end
    
  end
  
  def place_piece(color, pos)
    self[pos] = Piece.new(self, color, pos)
  end
end

$b = Board.new
$b.display

