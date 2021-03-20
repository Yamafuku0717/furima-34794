# README

## usersテーブル

|Column          | Type      |Options                  |
|----------------|-----------|-------------------------|
|nickname        |string     |null: false              |
|email           |string     |unique: true, null: false|
|password        |string     |null: false              |
|last_name       |string     |null: false              |
|first_name      |string     |null: false              |
|last_name_kana  |string     |null: false              |
|first_name_kana |string     |null: false              |
|birth_date      |date       |null: false              |

### Association
has_many :items
has_many :purchases


## itemsテーブル

|Column                  | Type      |Options            |
|------------------------|-----------|-------------------|
|name                    |string     |null: false        |
|description             |string     |null: false        |
|price                   |integer    |null: false        |
|user                    |references |foreign_key: true  |
|category_id             |integer    |null: false        |
|sales_status_id         |integer    |null: false        |
|shipping_free_status_id |integer    |null: false        |
|prefecture_id           |integer    |null: false        |
|scheduled_delivery_id   |integer    |null: false        |


### Association
belongs_to :user
belongs_to :category
belongs_to :sales_status
belongs_to :shipping_free_status
belongs_to :prefecture
belongs_to :scheduled_delivery
has_one :purchase
has_one_attached :image


## purchasesテーブル

|Column          | Type      |Options            |
|----------------|-----------|-------------------|
|postal_code     |string     |null: false        |
|prefecture_id   |integer    |null: false        |
|city            |string     |null: false        |
|addresses       |string     |null: false        |
|building        |string     |null: false        |
|phone_number    |string     |null: false        |
|user            |references |foreign_key :true  |
|item            |references |foreign_key :true  |

### Association
belongs_to :user
belongs_to :item
belongs_to :prefecture


## categories(active_hash)
### Association
has_many :items


## sales_statuses(active_hash)
### Association
has_many :items


## shipping_free_statuses(active_hash)
### Association
has_many :items


## scheduled_deliveries(active_hash)
### Association
has_many :items


## prefectures(active_hash)
### Association
has_many :items
has_many :purchases