class AddNumberToTracks < ActiveRecord::Migration[5.1]
  def change
    add_column :tracks, :number, :integer
  end
end
