require 'contracts'

class GamePiece

    include Contracts::Core
    include Contracts::Builtin
    include Contracts::Invariants

    Contract None => Any
    def initialize()
        raise NotImplementedError, "Objects that extend GamePiece must provide their own constructor."
    end

    Contract None => Any
    def get_image()
        return @image
    end

    # Load the @image_location into image.
    Contract None => None
    def load()

    end
end
