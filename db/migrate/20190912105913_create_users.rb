class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.text :description
      t.string :f_name
      t.string :l_name

      t.timestamps
    end
  end
end
