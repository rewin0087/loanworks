class CreateTriangles < ActiveRecord::Migration
  def change
    create_table :triangles do |t|
      t.integer :side_a
      t.integer :side_b
      t.integer :side_c
      t.integer :triangle_type

      t.timestamps null: false
    end
  end
end
