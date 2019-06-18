class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_enroll_for_current_course, only: [:show]

  def show
  end

  private

  def require_enroll_for_current_course
    if !current_user.enrolled_in?(current_lesson.section.course)
    redirect_to course_path(current_lesson.section.course), alert: "You must be enrolled to iew this lesson."
    end
  end

  helper_method :current_lesson
  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end
end
