# frozen_string_literal: true

module Base
  class Repository
    RepositoryError = Class.new(StandardError)
    def raise_error(message)
      raise Base::Repository::RepositoryError, message
    end
  end
end
