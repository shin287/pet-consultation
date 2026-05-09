class AddAnimalAndConsultationTypeToQuestions < ActiveRecord::Migration[8.1]
  def change
    add_column :questions, :animal_type, :string
    add_column :questions, :consultation_type, :string
    add_column :questions, :animal_other, :string
  end
end
