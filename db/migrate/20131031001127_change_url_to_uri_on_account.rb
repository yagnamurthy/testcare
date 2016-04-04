class ChangeUrlToUriOnAccount < ActiveRecord::Migration
  def change
  	rename_column :accounts, :url, :uri
  end
end
