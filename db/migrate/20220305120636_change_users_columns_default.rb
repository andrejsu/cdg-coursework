class ChangeUsersColumnsDefault < ActiveRecord::Migration[6.1]
  def change
    change_column_default :users, :name, ''
    change_column_default :users, :bio, ''
  end
end
