class CreateJoinTableCategorySubcategory < ActiveRecord::Migration[5.0]
  def change
    create_join_table :categories, :subcategories do |t|
      t.index [:category_id, :subcategory_id]
    end
  end
end
