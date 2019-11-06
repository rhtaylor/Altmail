class CreateMessages < ActiveRecord::Migration
  def change 
    create_table :messages do |t| 
          t.string :message 
           t.string :author 
           t.string :sent_to
  end
end
end