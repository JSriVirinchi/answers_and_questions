class Questionpaper < ApplicationRecord
	belongs_to :user
	has_many :questions, dependent: :destroy
	validates :name, presence: { message: 'should not be empty' }
	validates :name, uniqueness: { scope: :user_id , message: 'is already taken, give a unique name'}
	validates :default_marks, presence: {message: 'should not be empty'}
end