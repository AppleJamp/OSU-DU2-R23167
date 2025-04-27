class Group < ApplicationRecord
  # Asociace: Skupina má mnoho poznámek.
  has_many :notes, dependent: :destroy

  # Příklad validace (Bod 5)
  validates :name, presence: true, uniqueness: true
end