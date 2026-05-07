class AddAdditionalInfoToQuestions < ActiveRecord::Migration[8.1]
  def change
    add_column :questions, :additional_info, :text
  end
end
