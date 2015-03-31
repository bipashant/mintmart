class CreateCommunicationMedia < ActiveRecord::Migration
  def change
    create_table :communication_media do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
