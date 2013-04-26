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

      def all
        entities = []

        Tapir::Entities::Base.descendants.each do |x|
          x.all.each {|y| entities << y } unless x.all == [] 
        end
      entities
      end


    end
  end
end