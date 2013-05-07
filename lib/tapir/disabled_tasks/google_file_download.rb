# Returns the name of this task.
def name
  "google_file_download"
end

# Returns a string which describes this task.
def description
  "This task hits the Google API and grabs all interesting file. Optionally it can download them."
end

# Returns an array of valid types for this task
def allowed_types
  [ Tapir::Entities::SearchString, 
    Tapir::Entities::Domain]
end

def setup(entity, options={})
  super(entity, options)
  self
end

def run
  super

  file_type_list = ["pdf", "doc", "xls", "ppt", "txt"] || @options['file_type_list'].split(",")

  x = Tapir::Client::Google::SearchService.new

  file_type_list.each do |file_type|
    results = x.search("#{@entity.name} filetype:#{file_type}")

    results.each do |result|
      puts result.title
      puts result.content
      puts result.url
    end
  end
end

def cleanup
  super
end
