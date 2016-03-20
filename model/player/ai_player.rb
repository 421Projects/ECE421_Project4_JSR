require_relative "./player"

class AIPlayer < Player
    def play(board_to_play)
        # Enact the AI strategy here
        return (rand*board_to_play.width).to_i
    end
end
