module Tapir
  module Entities
    class Base

      include Mongoid::Document
      include EntityHelper

      field :name, type: String
      field :status, type: String
      field :confidence, type: Integer

      def to_s
        "#{entity_type} #{name}"
      end

      # Class method to convert to a path
      def self.path
        "/entities/#{self.id}"
      end

      # Class method to convert to a path
      def self.underscore
        self.class.to_s.downcase.gsub("::","_")
      end

      # Instance method to convert to a path
      def path
        "/entities/#{self.id}"
      end


      def all
        entities = []

        Tapir::Entities::Base.descendants.each do |x|
          x.all.each {|y| entities << y } unless x.all == [] 
        end
      entities
      end


      # This allows us to refer to all objects as entities
      # as opposed to working about generating path / url 
      # helpers for every type of entity
      # http://api.rubyonrails.org/classes/ActiveModel/Naming.html#method-c-param_key
      #def self.model_name
      #  super.class.model_name
      #end

      def model_name
        self.model_name
      end

      #def self.model_name
      #  super.model_name
      #end

      extend ActiveModel::Naming

    end
  end
end