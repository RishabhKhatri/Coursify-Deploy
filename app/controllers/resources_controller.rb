class ResourcesController < ApplicationController

  include SessionsHelper
  include ResourcesHelper

  before_action :check_sign_in

  def create
    @course = Course.find_by(code: params[:code])
    @resource = @course.resources.build(resource_params)
    if @resource.save!
      embed_link(@resource)
      flash[:success] = "Resource uploaded successfully."
      redirect_to resources_url(subdomain: current_institute.subdomain)
    else
      render 'index'
    end
  end

  def index
    @course = Course.find_by(code: params[:code])
  end

  def update
    @resource = Resource.find_by(id: params[:id])
    if @resource.update_attributes(resource_params)
      embed_link(@resource)
      flash[:success] = "Resource updated successfully."
      redirect_to resources_url(subdomain: current_institute.subdomain)
    else
      render 'index'
    end
  end

  def destroy
    Resource.find_by(id: params[:id]).destroy
    flash[:info] = "Resource deleted successfully."
    redirect_to resources_url(subdomain: current_institute.subdomain)
  end

  private

    def resource_params
      params.require(:resource).permit(:title, :instructions, :video, :attachment, :course_id)
    end

    def check_sign_in
      unless teacher_signed_in?
        flash[:danger] = "Please sign in."
        redirect_to login_url(subdomain: 'accounts')
      end
    end

    # def check_correct_user
    #   @course = Course.find_by(code: params[:code])
    #   correct_teacher = Teacher.find_by(id: @course.teacher_id)
    #   unless correct_teacher == current_teacher
    #     flash[:danger] = "Unauthorized user."
    #     redirect_to root_url(subdomain: '')
    #   end
    # end
end
