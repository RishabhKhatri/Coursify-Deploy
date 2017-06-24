class InstitutesController < ApplicationController

  include SessionsHelper

  before_action :check_sign_in
  before_action :check_admin_user, only: [:destroy, :edit, :update, :teacher_index, :remove_teacher]
  before_action :check_teacher_admin, only: [:index, :destroy]

  def new
    @institute = Institute.new
  end

  def index
    @institutes = Institute.all
  end

  def show
    @institute = Institute.find_by_subdomain!(request.subdomain)
    @admin = Teacher.find_by(email: @institute.admin)
  end

  def edit
    @institute = Institute.find_by_subdomain!(request.subdomain)
  end

  def create
    @institute = Institute.new(institute_params)
    @institute.admin = current_teacher.email
    if @institute.save
      flash[:success] = "Institute created and added to your Profile successfully."
      current_teacher.institute_id = @institute.id
      current_teacher.save!
      redirect_to root_url(subdomain: '')
    else
      render 'new'
    end
  end

  def update
    @institute = Institute.find(params[:id])
    if @institute.update_attributes(institute_params)
      flash[:success] = "Successfully updated Institute details."
      redirect_to institute_url(@institute, subdomain: @institute.subdomain)
    else
      render 'edit'
    end
  end

  def destroy
    Institute.find(params[:id]).destroy
    flash[:success] = "Institute deleted successfully."
    redirect_to root_url(subdomain: '')
  end

  def teacher_index
    @institute = Institute.find_by(id: params[:id])
  end

  def remove_teacher
    @teacher = Teacher.find_by(id: params[:id])
    @teacher.institute_id = nil
    if @teacher.save!
      flash[:success] = "#{@teacher.name} removed successfully."
      redirect_to teacher_index_url(current_institute, subdomain: current_institute.subdomain)
    else
      flash[:danger] = "Something went wrong."
      redirect_to teacher_index_url(subdomain: current_institute.subdomain)
    end
  end

  private

    def institute_params
      params.require(:institute).permit(:name, :subdomain, :admin)
    end

    def check_sign_in
      if !teacher_signed_in?
        flash[:danger] = "Please sign in."
        redirect_to root_url(subdomain: '')
      end
    end

    def check_admin_user
      unless current_teacher.email.eql? current_institute.admin
        flash[:danger] = "Unauthorized user."
        redirect_to root_url(subdomain: '')
      end
    end

    def check_teacher_admin
      unless current_teacher.admin?
        flash[:danger] = "Unauthorized user."
        redirect_to root_url(subdomain: '')
      end
    end
end
