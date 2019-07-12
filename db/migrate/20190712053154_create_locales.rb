class CreateLocales < ActiveRecord::Migration[5.2]
  def change
    create_table :locales do |t|
      t.string :code, null: false
      t.string :name, null: false
      t.timestamps
    end
  end
end
