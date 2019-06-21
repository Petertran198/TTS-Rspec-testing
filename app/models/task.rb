class Task < ApplicationRecord
    validates :name, presence: true
    validates :priority, presence: true
    belongs_to :user
end
