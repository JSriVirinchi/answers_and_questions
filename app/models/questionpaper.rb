class Questionpaper < ApplicationRecord
	belongs_to :user
	validates :name, presence: { message: 'should not be empty' }
	validates :name, uniqueness: { scope: :user_id , message: 'is already taken. Give unique name'}
end