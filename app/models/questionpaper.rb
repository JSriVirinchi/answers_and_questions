class Questionpaper < ApplicationRecord
	belongs_to :user
	has_many :questions, dependent: :destroy
	validates :name, presence: { message: 'should not be empty' }
	validates :name, uniqueness: { scope: :user_id , message: 'is already taken. Give unique name'}
end