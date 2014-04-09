class CreateGemBuilders < ActiveRecord::Migration
  def change
    create_table :gem_builders do |t|
      t.string :name
      t.string :creator
      t.text :description

      t.timestamps
    end
  end
end
