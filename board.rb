load "./piece.rb"

class Board
  
  attr_accessor :matrix
  
  def initialize
    @rows = Array.new(8) {Array.new(8)}
  end
  
  def [] pos
    @rows[pos[0]][pos[1]]
  end
  
  def []= pos, val
    @rows[pos[0]][pos[1]] = val
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
      black: [[0,0], [0,2], [0,4], [0,6], 
      [1,1], [1,3], [1,5], [1,7],
      [2,0], [2,2], [2,4], [2,6]],
      
      red: [[5,1], [5,3], [5,5], [5,7],
        [6,0], [6,2], [6,4], [6,6], 
        [7,1], [7,3], [7,5], [7,7]] 
    }
    pieces.each do |color, positions|
      positions.each {|pos| place_piece(color, pos)}
    end
    
  end
  
  def place_piece(color, pos)
    self[pos] = Piece.new(self, color, pos)
  end
end

$b = Board.new
$b.set_pieces

