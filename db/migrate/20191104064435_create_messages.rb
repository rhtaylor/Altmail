class CreateMessages < ActiveRecord::Migration
  def change 
    create_table :messages do |t| 
          t.string :message 
           t.string :author 
           t.integer :sent_to
  end
end
end