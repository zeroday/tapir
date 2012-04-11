class CreateParsableFiles < ActiveRecord::Migration
  def change
    create_table :parsable_files do |t|
      t.string :name
      t.string :type
      t.string :path

      t.timestamps
    end
  end
end
