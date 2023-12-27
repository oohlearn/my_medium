class Story < ApplicationRecord
  include AASM
  belongs_to :user
  validates :title, presence: true
  default_scope {where(delete_at: nil)}
  # 上面那行加上去後，所有查詢動作時都會預設加上的delte_at的值是nil的篩選
  # 也就是會找出沒有被軟刪除的資料

  # 覆寫destroy方法
  def destroy
    update(delete_at: Time.now)
    # 在这个方法内,它使用update方法来将deleted_at字段更新为当前时间。 
    # 所以记录不会被真正删除,只是打上一个deleted_at标记。
    # 这种方式即实现了逻辑上的“删除”,又保留了数据,达到软删除的目的。
    # 后续通过Scopes或查询时,可以根据deleted_at是否存在来判断记录是否被删除。
  end

  aasm(column: "status", no_direct_assignment: true) do 
    # gem本身預設是有個column，現在告訴他我們要用status當作參考
    state :draft, initial: true
    state :published

    event :publish do
      transitions from: :draft, to: :published
    end

    event :unpublish do
      transitions from: :published, to: :draft
    end
  end

end
