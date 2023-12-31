class CreateStories < ActiveRecord::Migration[7.1]
  def change
    create_table :stories do |t|
      t.string :title
      t.text :content
      t.string :status, default: "draft"
      # 將故事的狀態初始設定為"草稿"
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
