class CoursesController < ApplicationController

  include SessionsHelper

  before_action :check_sign_in
  before_action :check_correct_user, only: [:edit, :update, :show, :destroy]
  before_action :check_archived, only: [:edit, :update, :destroy]

  def new
    @course = Course.new
  end

  def create
    @course = current_teacher.courses.build(course_params)
    if @course.save
      flash[:success] = "#{@course.code.upcase} created successfully."
      redirect_to course_url(@course, subdomain: current_institute.subdomain)
    else
      render 'new'
    end
  end

  def show
    @course = Course.find_by(code: params[:code])
  end

  def index
    @courses = current_teacher.courses
  end

  def edit
    @course = Course.find_by(code: params[:code])
  end

  def update
    @course = Course.find_by(code: params[:code])
    if @course.update_attributes(course_params)
      flash[:success] = "#{@course.code} successfully updated."
      redirect_to root_url(subdomain: current_institute.subdomain)
    else
      render 'edit'
    end
  end

  def archive
    @course = Course.find_by(code: params[:code])
    @course.archived = true
    if @course.save!
      flash[:success] = "Course archived."
      redirect_to root_url(subdomain: current_institute.subdomain)
    else
      render 'index'
    end
  end

  def destroy
    Course.find_by(code: params[:code]).destroy
    flash[:info] = "Course successfully deleted."
    redirect_to courses_url(subdomain: current_institute.subdomain)
  end

  private

    def course_params
      params.require(:course).permit(:name, :code, :summary, :start_date, :end_date, :teacher_id)
    end

    def check_sign_in
      unless teacher_signed_in?
        flash[:danger] = "Please sign in."
        redirect_to login_url(subdomain: 'accounts')
      end
    end

    def check_correct_user
      @course = Course.find_by(code: params[:code])
      correct_teacher = Teacher.find_by(id: @course.teacher_id)
      unless correct_teacher == current_teacher
        flash[:danger] = "Unauthorized user."
        redirect_to root_url(subdomain: '')
      end
    end

    def check_archived
      @course = Course.find_by(code: params[:code])
      correct_teacher = Teacher.find_by(id: @course.teacher_id)
      unless !@course.archived?
        flash[:danger] = "Sorry, this course is archived."
        redirect_to root_url(subdomain: current_institute.subdomain)
      end
    end
end
