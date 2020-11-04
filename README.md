#テーブル設計

##users テーブル

| Column             | Type      | Options     |
| ------------------ | --------- | ----------- |
| nickname           | string    | null: false |
| email              | string    | null: false |
| encrypted_password | string    | null: false |
| first_name         | string    | null: false |
| last_name          | string    | null: false |
| first_name_kana    | string    | null: false |
| last_name_kana     | string    | null: false |
| birthday           | date      | null: false |

### Association

- has_many :items
- has_many :buyer_addresses
- has_many :buyer_numbers

##items テーブル

| Column      | Type       | Options                        |
| ----------  | ------     | -----------                    |
| name        | string     | null: false                    |
| content     | text       | null: false                    |
| category_id | integer    | null: false                    |
| status_id   | integer    | null: false                    | 
| cost_id     | integer    | null: false                    |
| area_id     | integer    | null: false                    |
| date_id     | integer    | null: false                    |
| price_id    | integer    | null: false                    |
| image       |            | null: false                    |activestorageで実装
| user        | references | null: false, foreign_key: true |

###Association

- belongs_to :user
- has_one :buyer_address
- has_one :buyer_number


##buyer_number テーブル

| Column          | Type       | Options                       |
| --------------  | ---------- | ----------------------------- |
| postnumber      | string     | null: false                   |
| telephonenumber | string     | null: false                   |
| user            | references | null: false, foreign_key: true |
| item            | references | null: false, foreign_key: true |

###Association

- belongs_to :user
- belongs_to :item
- has_one :buyer_address

##buyer_address テーブル


| Column          | Type       | Options                       |
| --------------  | ---------- | ----------------------------- |
| area1           | string     | null: false                   |
| area2           | string     | null: false                   |
| area3           | string     | null: false                   |
| building_name   | string     | null: false                   |
| user            | references | null: false, foreign_key: true |
| item            | references | null: false, foreign_key: true |
| buyer_number    | references | null: false, foreign_key: true |

###Association

- belongs_to :user
- belongs_to :item
- belongs_to :buyer_number
