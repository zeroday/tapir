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
        self.class.to_s.downcase.gsub("::","/")
      end

      # Class method to convert to a path
      def self.underscore
        self.class.to_s.downcase.gsub("::","_")
      end

      # Instance method to convert to a path
      def path
        self.class.to_s.downcase.gsub("::","/")
      end

      # Instance method to convert to a path
      def underscore
        self.class.to_s.downcase.gsub("::","_")
      end

      def entity_type
        self.class.to_s.downcase.split("::").last
      end

      def to_s
        "#{entity_type} #{name}"
      end

    end
  end
end