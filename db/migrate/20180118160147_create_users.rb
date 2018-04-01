class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :second_name
      t.string :sex
      t.string :age
      t.date   :dob
      t.timestamps
    end
  end
end
