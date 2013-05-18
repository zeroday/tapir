module Tapir
  module Entities
    class User < Base
      field :first_name, type: String
      field :last_name, type: String
      field :middle_name, type: String
      field :email_addresses, type: String
      
      has_many :usernames
      accepts_nested_attributes_for :usernames, :allow_destroy => true

      def name
        "#{first_name} #{last_name}"
      end
      
    private

      def default_values
        self.usernames ||= []
      end
      
      def set_usernames_empty
        self.usernames.uniq!
        self.save!
      end

      #
      # Do some basic cleanup on the usernames. Make sure they're unique, and
      # that they've been created without spaces
      #
      def cleanup_usernames
         
        #
        # Handle a string of comma separated (coming from the webui
        #
        self.usernames = self.usernames.split(",") if self.usernames.kind_of? String

        #
        # Make sure there's no spaces in the usernames
        #
        self.usernames.each {|u| u.gsub!(/\s+/, "")}
        
        #
        # Make sure all usernames are lowercase
        #
        self.usernames.each {|u| u.downcase!}
        
        #
        # Make sure we don't have multiple same usernames
        #
        self.usernames.uniq!
      end

    end
  end
end
