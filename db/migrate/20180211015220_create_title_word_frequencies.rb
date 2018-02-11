class CreateTitleWordFrequencies < ActiveRecord::Migration[5.1]
  def change
    create_table :title_word_frequencies do |t|
      t.references :artist, foreign_key: true
      t.string :word
      t.integer :appearances

      t.timestamps
    end
  end
end
