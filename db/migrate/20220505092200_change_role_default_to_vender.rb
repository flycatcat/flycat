# frozen_string_literal: true

class ChangeRoleDefaultToVender < ActiveRecord::Migration[6.1]
  def change
    change_column_default :users, :role, 'vendor'
  end
end
