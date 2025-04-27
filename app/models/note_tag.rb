class NoteTag < ApplicationRecord
  belongs_to :note
  belongs_to :tag

  # Zajištění unikátnosti páru note_id a tag_id,
  # aby jedna poznámka nemohla mít stejný tag vícekrát.
  validates :note_id, uniqueness: { scope: :tag_id }
end