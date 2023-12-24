class Story < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  default_scope {where(delete_at: nil)}
  # 上面那行加上去後，所有查詢動作時都會預設加上的delte_at的值是nil的篩選
  # 也就是會找出沒有被軟刪除的資料

  # 覆寫destroy方法
  def destroy
    update(delete_at: Time.now)
  end
end
# 在这个方法内,它使用update方法来将deleted_at字段更新为当前时间。
# 所以记录不会被真正删除,只是打上一个deleted_at标记。
# 这种方式即实现了逻辑上的“删除”,又保留了数据,达到软删除的目的。
# 后续通过Scopes或查询时,可以根据deleted_at是否存在来判断记录是否被删除。