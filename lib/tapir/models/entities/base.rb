module Tapir
  module Entities
    class Base

      include Mongoid::Document
      include EntityHelper

      field :name, type: String
      field :status, type: String
      field :confidence, type: Integer

      # Class method to convert to a path
      def self.path
        self.to_s.downcase.gsub("::","/")
      end

      # Class method to convert to a path
      def self.underscore
        self.to_s.downcase.gsub("::","_")
      end


      # Instance method to convert to a path
      def path
        self.to_s.downcase.gsub("::","/")
      end

      # Instance method to convert to a path
      def underscore
        self.to_s.downcase.gsub("::","_")
      end

    end
  end
end