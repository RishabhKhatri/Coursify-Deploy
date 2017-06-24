class DeadlinesController < ApplicationController

  include SessionsHelper

  before_action :check_sign_in

  def index
    @course = Course.find_by(code: params[:code])
  end

  def create
    @course = Course.find_by(code: params[:code])
    @deadline = @course.deadlines.build(deadline_params)
    if @deadline.save!
      flash[:success] = "Deadline created successfully."
      redirect_to deadlines_url(subdomain: current_institute.subdomain)
    else
      render 'index'
    end
  end

  def update
    @deadline = Deadline.find_by(id: params[:id])
    if @deadline.update_attributes(deadline_params)
      flash[:success] = "#{@deadline.title} updated successfully."
      redirect_to deadlines_url(subdomain: current_institute.subdomain)
    else
      render 'index'
    end
  end

  def destroy
    Deadline.find_by(id: params[:id]).destroy
    flash[:info] = "Deadline deleted successfully."
    redirect_to deadlines_url(subdomain: current_institute.subdomain)
  end

  private

    def deadline_params
      params.require(:deadline).permit(:title, :instructions, :attachment, :link, :due_date, :end_time)
    end

    def check_sign_in
      unless teacher_signed_in?
        flash[:danger] = "Please sign in."
        redirect_to login_url(subdomain: 'accounts')
      end
    end
end
