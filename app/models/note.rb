class Note < ApplicationRecord
  # Asociace: Poznámka patří do jedné skupiny.
  belongs_to :group

  # Asociace pro M:N vztah se štítky přes spojovací tabulku note_tags.
  has_many :note_tags, dependent: :destroy
  has_many :tags, through: :note_tags

  # Příklad Enum (Bod 7)
  enum :status, { draft: 0, published: 1, archived: 2 }

  # Příklad validací (Bod 5)
  validates :title, presence: true, length: { minimum: 3 } # Další 2 typy validací
  validates :content, presence: true

  # Příklad Callbacku (Bod 4)
  before_save :set_default_status

  # Příklad vlastní validace (Bod 6)
  validate :content_should_not_contain_forbidden_words

  private

  def set_default_status
    # Nastaví status na 'draft', pokud ještě není nastaven
    self.status ||= :draft
  end

  def content_should_not_contain_forbidden_words
    forbidden_words = ["zakazane_slovo1", "zakazane_slovo2"]
    if content.present? && forbidden_words.any? { |word| content.include?(word) }
      errors.add(:content, "obsahuje zakázaná slova")
    end
  end

  # Příklad Callbacku (Bod 4)
  after_create :log_creation

  def log_creation
    puts "Poznámka '#{title}' byla úspěšně vytvořena."
  end
end