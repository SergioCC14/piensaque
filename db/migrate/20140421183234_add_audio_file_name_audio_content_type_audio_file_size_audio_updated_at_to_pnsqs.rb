class AddAudioFileNameAudioContentTypeAudioFileSizeAudioUpdatedAtToPnsqs < ActiveRecord::Migration
  def change
    remove_column :pnsqs, :audio
    add_attachment :pnsqs, :audio
  end
end
