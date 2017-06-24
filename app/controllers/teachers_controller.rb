class TeachersController < ApplicationController

  include SessionsHelper

  before_action :check_sign_in, only: [:edit, :update, :show, :destroy, :index]
  before_action :check_correct_user, only: [:edit, :update, :show]
  before_action :check_admin_user, only: [:destroy, :index]
  before_action :check_not_signed_in, only: [:new, :create]

  def index
    @teachers = Teacher.all
  end

  def new
    @teacher = Teacher.new
  end

  def show
    @teacher = Teacher.find(params[:id])
  end

  def create
    @teacher = Teacher.new(teacher_params)
    if @teacher.save
      TeacherMailer.account_activation(@teacher).deliver_now
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url(subdomain: '')
    else
      render 'new'
    end
  end

  def edit
    if !session[:user_id].nil?
      @teacher = Teacher.find(session[:user_id])
    else
      @teacher = Teacher.find_by(email: session[:cas][:extra_attributes][:email])
    end
  end

  def edit_channel
    if !session[:user_id].nil?
      @teacher = Teacher.find(session[:user_id])
    else
      @teacher = Teacher.find_by(email: session[:cas][:extra_attributes][:email])
    end
  end

  def update
    @teacher = Teacher.find(params[:id])
    if @teacher.update_attributes(techer_update_params(@teacher))
      flash[:success] = "Profile updated successfully."
      redirect_to teacher_url(@teacher, subdomain: '')
    else
      render 'edit'
    end
  end

  def destroy
    Teacher.find(params[:id]).destroy
    flash[:success] = "User deleted successfully."
    redirect_to teachers_url(subdomain: '')
  end

  private

    def teacher_params
      params.require(:teacher).permit(:name, :email, :contact, :expertise, :password, :password_confirmation, :picture, :institute_id)
    end

    def techer_update_params(teacher)
      if teacher.institute_id.nil?
        params.require(:teacher).permit(:name, :contact, :expertise, :password, :password_confirmation, :picture, :institute_id)
      else
        params.require(:teacher).permit(:name, :contact, :expertise, :password, :password_confirmation, :picture)
      end
    end

    def check_sign_in
      if user_signed_in?
        flash[:danger] = "Please sign in yo."
        redirect_to root_url(subdomain: '')
      end
    end

    def check_not_signed_in
      if !user_signed_in?
        flash[:danger] = "Not allowed!"
        redirect_to root_url(subdomain: '')
      end
    end

    def check_correct_user
      @teacher = Teacher.find(params[:id])

      flash[:danger] = "Unauthorized user." unless @teacher == current_teacher
      redirect_to root_url(subdomain: '') unless @teacher == current_teacher
    end

    def check_admin_user
      unless current_teacher.admin?
        flash[:danger] = "Unauthorized user."
        redirect_to root_url(subdomain: '')
      end
    end

end
