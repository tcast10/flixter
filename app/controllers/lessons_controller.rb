class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_enroll_for_current_course, only: [:show]

  def show
    @lesson = current_lesson.section.course.show(current_lesson)
    if current_user.enrolled_in?
      redirect_to lesson_path(@course)
    else
      redirect_to current_course
    end
  end

  private

  def require_enroll_for_current_course
    if current_user.enrolled_in? != current_user
      redirect_to current_course, alert: 'You Need to Enroll First'
    end
  end

  helper_method :current_lesson
  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end
end
