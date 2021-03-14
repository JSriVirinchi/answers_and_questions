class Questionpaper < ApplicationRecord
	validates :name, presence: { message: 'should not be empty' }
	validates :name, uniqueness: { scope: :user_id , message: 'is already taken. Give unique name'}
end