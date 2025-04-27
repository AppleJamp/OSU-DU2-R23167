class Tag < ApplicationRecord
  # Asociace pro M:N vztah s poznámkami přes spojovací tabulku note_tags.
  has_many :note_tags, dependent: :destroy
  has_many :notes, through: :note_tags

  # Validace (Bod 5 ze zadání)
  # Jméno tagu musí být přítomné
  validates :name, presence: true
  # Jméno tagu musí být unikátní (bez ohledu na velikost písmen)
  validates :name, uniqueness: { case_sensitive: false }
end