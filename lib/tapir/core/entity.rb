require 'singleton'

module Tapir
  class Entity

    def first
      self.all.first
    end

    def last
      self.all.last
    end

    def tasks
      tasks = []
    end

  end
end
