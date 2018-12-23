class CreateThermostats < ActiveRecord::Migration[5.2]
  def change
    create_table :thermostats do |t|
      t.text :household_token, null: false
      t.string :location, null: false

      t.timestamps
    end
  end
end
