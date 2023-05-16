# frozen_string_literal: true

module Base
  RepositoryError = Class.new(StandardError)
  
  class Repository
    def raise_error(message)
      raise Base::RepositoryError, message
    end
  end
end
