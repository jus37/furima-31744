#テーブル設計

##users テーブル

| Column            | Type      | Options     |
| ----------------- | --------- | ----------- |
| nickname          | string    |             |
| email             | string    |             |
| password          | string    |             |
| first_name        | string    |             |
| last_name         | string    |             |
| first_name_kana   | string    |             |
| last_name_kana    | string    |             |
| year              | date      |             |
| month             | date      |             |
| day               | date      |             |

### Association

- has_many :items
- has_many :buyers

##items テーブル

| Column   | Type       | Options                        |
| -------- | ------     | -----------                    |
| name     | string     |                                |
| content  | text       |                                |
| category | integer    |                                |
| status   | integer    |                                | 
| cost     | integer    |                                |
| area     | integer    |                                |
| date     | integer    |                                |
| price    | integer    |                                |
| image    |            |                                |activestorageで実装
| user     | references |              foreign_key: true |

###Association

- belongs_to :user
- belongs_to :buyer


##buyer テーブル

| Column          | Type       | Options                       |
| --------------  | ---------- | ----------------------------- |
| postnumber      | integer    |                               |
| area1           | string     |                               |
| area2           | string     |                               |
| area3           | string     |                               |
| building_name   | string     |                               |
| telephonenumber | integer    |                               |
| user            | references |             foreign_key: true |
| item            | references |             foreign_key: true |

###Association

- belongs_to :user
- belongs_to :item
