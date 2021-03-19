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
|birth_year      |string     |null: false              |
|birth_month     |string     |null: false              |
|birth_day       |string     |null: false              |

### Association
has_many :items
has_many :purchases


## itemsテーブル

|Column                  | Type      |Options            |
|------------------------|-----------|-------------------|
|name                    |string     |null: false        |
|description             |string     |null: false        |
|price                   |integer    |null: false        |
|user_id                 |references |foreign_key: true  |
|category_id             |references |foreign_key: true  |
|sales_status_id         |references |foreign_key: true  |
|shipping_free_status_id |references |foreign_key: true  |
|prefecture_id           |references |foreign_key: true  |
|scheduled_delivery_id   |references |foreign_key: true  |


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
|prefecture_id   |references |foreign_key: true  |
|city            |string     |null: false        |
|addresses       |string     |null: false        |
|building        |string     |null: false        |
|phone_number    |string     |null: false        |
|user_id         |references |foreign_key :true  |
|item_id         |references |foreign_key :true  |

### Association
belongs_to :user
belongs_to :item
belongs_to :prefecture


## categories(active_hash)

|Column   |Type   |Options     |
|---------|-------|------------|
|category |string |null: false |

### Association
has_many :items


## sales_statuses(active_hash)

|Column   |Type   |Options     |
|---------|-------|------------|
|status   |string |null: false |

### Association
has_many :items


## shipping_free_statuses(active_hash)

|Column               |Type      |Options     |
|---------------------|----------|------------|
|shipping_free_status |string    |null: false |

### Association
has_many :items


## scheduled_deliveries(active_hash)

|Column             |Type   |Options     |
|-------------------|-------|------------|
|scheduled_delivery |string |null: false |

### Association
has_many :items


## prefectures(active_hash)

|Column     |Type    |Options     |
|-----------|--------|------------|
|prefecture |string  |null: false |

### Association
has_many :items
has_many :purchases