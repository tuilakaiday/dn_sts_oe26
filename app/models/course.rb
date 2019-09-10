class Course < ApplicationRecord
  attr_accessor :locations, :statuses

  has_many :course_users, dependent: :destroy
  has_many :users, through: :course_users
  has_many :course_subjects, dependent: :destroy
  has_many :subjects, through: :course_subjects
  has_many :user_course_tasks, dependent: :destroy
  has_many :users, through: :user_course_tasks
  has_many :tasks, through: :user_course_tasks

  enum location: {da_nang: 0, tp_hcm: 1, ha_noi: 2}
  enum status: {archive: 0, running: 1, finish: 2}
  validates :name, presence: true,
    length: {maximum: Settings.course.max_length_name}
  validates :content, presence: true,
    length: {maximum: Settings.course.max_length_content}

  scope :load_courses, ->(stt) do
    stt ? where(status: stt) : where(status: [:archive, :running, :finish])
  end
  scope :order_by, ->{order(created_at: :desc)}

  def start_course
    update_columns(start_date: Time.zone.now, status: :running)
  end

  def finish_course
    update_columns(status: :finish)
  end
end
