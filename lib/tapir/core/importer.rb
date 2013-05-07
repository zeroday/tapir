module Tapir
class Importer

  #
  #  Import users from file
  #
  def import_users(file)
    import_file = file
    FasterCSV.parse(import_file.read).each do |row|
      temp_user = Tapir::Entities::User.new(:email => row[0], :first_name => row[1], :last_name => row[2])
      temp_user.save!  
    end
  end

  #
  #  Export users to a file
  #
  def export_users(file)
    users = Tapir::Entities::User.all

    csv_string = FasterCSV.generate do |csv|
      users.each do |user|
        csv << [user.email, user.first_name, user.last_name]
      end
    end

    send_data csv_string,
              :type => 'text/csv; charset=iso-8859-1; header=present',
              :disposition => "attachment; filename=users.csv"
    File.open(file,"w").write
  end

  #
  #  Generic import
  #
  def import_file(file)
    f = File.open(file, "r")

    # Open the file and create entities for each line
    f.each_line do |line| 
      begin
        if line
          TapirLogger.instance.log "Importing #{line}"
          import_items = line.split(",")
          TapirLogger.instance.log "items: #{import_items}"
          case import_items[0]
            when "organization"
              TapirLogger.instance.log "Creating an organization!"
              Tapir::Entities::Organization.create(:name => import_items[1].strip)
            when "domain"
              TapirLogger.instance.log "Creating a domain!"
              Tapir::Entities::Domain.create(:name => import_items[1].strip)
            when "host"
              TapirLogger.instance.log "Creating a host!"
              Tapir::Entities::Host.create(:ip_address => import_items[1].strip)
            when "user"
              TapirLogger.instance.log "Creating a user!"
              Tapir::Entities::User.create(:first_name => import_items[1].strip, 
                          :last_name => import_items[2].strip)
          end  
        end
      rescue Exception => e
        TapirLogger.instance.log "Couldn't import #{e}"
      end
    end
  end
end
end
