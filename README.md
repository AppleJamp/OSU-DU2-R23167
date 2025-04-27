# Domácí úloha 2 - Poznámková aplikace

Jednoduchá webová aplikace v Ruby on Rails pro správu poznámek, skupin a štítků.

## Splnění požadavků zadání

Zde je přehled splnění jednotlivých bodů zadání:

1.  **Alespoň 3 DB tabulky a k nim definované modely [1 bod]**
    * **Řešeno:** Byly vytvořeny modely `Group`, `Note` a `Tag`.
    * Místo v kódu:
        * [`app/models/group.rb:1`](./app/models/group.rb)
        * [`app/models/note.rb:1`](./app/models/note.rb)
        * [`app/models/tag.rb:1`](./app/models/tag.rb)
        * Odpovídající migrace v `db/migrate/`

2.  **Modely budou mezi sebou logicky provázány pomocí asociací s dependencemi [1 bod]**
    * **Řešeno:** Modely jsou propojeny pomocí `has_many`, `belongs_to`, `has_many :through` a obsahují `dependent: :destroy` pro správu závislostí při mazání.
    * Místo v kódu:
        * [`app/models/group.rb:3`](./app/models/group.rb) (`has_many :notes`)
        * [`app/models/note.rb:3`](./app/models/note.rb) (`belongs_to :group`)
        * [`app/models/note.rb:6`](./app/models/note.rb) (`has_many :note_tags`)
        * [`app/models/note.rb:7`](./app/models/note.rb) (`has_many :tags`)
        * [`app/models/tag.rb:3`](./app/models/tag.rb) (`has_many :note_tags`)
        * [`app/models/tag.rb:4`](./app/models/tag.rb) (`has_many :notes`)
        * [`app/models/note_tag.rb:2`](./app/models/note_tag.rb) (`belongs_to :note`)
        * [`app/models/note_tag.rb:3`](./app/models/note_tag.rb) (`belongs_to :tag`)

3.  **Mezi nějakými dvěma tabulkami bude definována vazba M:N, spojovací tabulka se nezapočítává do 3 tabulek definovaných v bodu 1 [2 body]**
    * **Řešeno:** Mezi modely `Note` a `Tag` je implementována vazba M:N pomocí spojovacího modelu `NoteTag` a tabulky `note_tags`.
    * Místo v kódu:
        * [`app/models/note.rb:7`](./app/models/note.rb) (`has_many :tags, through: :note_tags`)
        * [`app/models/tag.rb:4`](./app/models/tag.rb) (`has_many :notes, through: :note_tags`)
        * [`app/models/note_tag.rb:1`](./app/models/note_tag.rb) (definice třídy `NoteTag`)
        * Migrace pro `create_note_tags` v `db/migrate/`

4.  **Použití alespoň 2 callbacků - jaké a jejich použití je čistě na Vás [1 bod]**
    * **Řešeno:** V modelu `Note` jsou použity callbacky `before_save` (pro nastavení výchozího statusu) a `after_create` (pro ukázkové logování).
    * Místo v kódu:
        * [`app/models/note.rb:15`](./app/models/note.rb) (deklarace `before_save :set_default_status`)
        * [`app/models/note.rb:32`](./app/models/note.rb) (deklarace `after_create :log_creation`)
        * [`app/models/note.rb:21-24`](./app/models/note.rb) (definice metody `set_default_status`)
        * [`app/models/note.rb:34-36`](./app/models/note.rb) (definice metody `log_creation`)

5.  **Využití 4 různých typů validací [2 bod]**
    * **Řešeno:** Jsou použity validace `presence`, `uniqueness`, `length` a `uniqueness` s `scope`.
    * Místo v kódu:
        * [`app/models/group.rb:6`](./app/models/group.rb) (`validates :name, presence: true, uniqueness: true`)
        * [`app/models/tag.rb:8`](./app/models/tag.rb) (`validates :name, presence: true`)
        * [`app/models/tag.rb:10`](./app/models/tag.rb) (`validates :name, uniqueness: { case_sensitive: false }`)
        * [`app/models/note.rb:11`](./app/models/note.rb) (`validates :title, presence: true, length: { minimum: 3 }`)
        * [`app/models/note.rb:12`](./app/models/note.rb) (`validates :content, presence: true`)
        * [`app/models/note_tag.rb:7`](./app/models/note_tag.rb) (`validates :note_id, uniqueness: { scope: :tag_id }`)

6.  **Využití vlastní validační metody v aplikaci [1 bod]**
    * **Řešeno:** V modelu `Note` je použita vlastní validační metoda `content_should_not_contain_forbidden_words`.
    * Místo v kódu:
        * [`app/models/note.rb:18`](./app/models/note.rb) (deklarace `validate :content_should_not_contain_forbidden_words`)
        * [`app/models/note.rb:26-30`](./app/models/note.rb) (definice metody `content_should_not_contain_forbidden_words`)

7.  **Použití enum alespoň v jednom modelu [1 bod]**
    * **Řešeno:** V modelu `Note` je použit `enum` pro atribut `status`.
    * Místo v kódu:
        * [`app/models/note.rb:9`](./app/models/note.rb) (řádek s `enum :status, { ... }`)

8.  **Data alespoň u dvou modelů bude možné vkládat, editovat a mazat z UI aplikace [1 bod]**
    * **Řešeno:** Pro modely `Group` a `Note` byl vygenerován scaffold, který poskytuje kompletní CRUD operace přes webové rozhraní. Pro model `Tag` byl také vygenerován scaffold.
    * Místo v kódu:
        * [`app/controllers/groups_controller.rb`](./app/controllers/groups_controller.rb) a `app/views/groups/`
        * [`app/controllers/notes_controller.rb`](./app/controllers/notes_controller.rb) a `app/views/notes/`
        * [`app/controllers/tags_controller.rb`](./app/controllers/tags_controller.rb) a `app/views/tags/`
        * [`config/routes.rb`](./config/routes.rb) (řádky s `resources :groups`, `resources :notes`, `resources :tags`)

*(Poznámka: Čísla řádků odpovídají poskytnutým souborům.)*
