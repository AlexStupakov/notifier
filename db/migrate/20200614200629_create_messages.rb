class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.string :template
      t.string :name

      t.timestamps
    end
  end
end
