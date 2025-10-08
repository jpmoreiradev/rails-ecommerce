class AddDeviseToUsers < ActiveRecord::Migration[8.0]
  def self.up
    # Adiciona a coluna email somente se não existir
    add_column :users, :email, :string, default: "", null: false unless column_exists?(:users, :email)

    change_table :users do |t|
      t.string :encrypted_password, null: false, default: ""
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at
    end

    add_index :users, :email, unique: true
    add_index :users, :reset_password_token, unique: true
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
