class RegisteredApplicationsController < ApplicationController

  def index
      @applications = RegisteredApplication.all
  end

  def show
    @application = RegisteredApplication.find(params[:id])
    @event_groups = @application.events.group_by(&:name)
  end

  def new
    @application = RegisteredApplication.new(url: "http://")
  end

  def create
    @application = RegisteredApplication.new(application_params)
    @application.user = current_user

      if @application.save
        flash[:success] = "Application Added"
        redirect_to registered_applications_path
      else
        render 'new'
      end
  end

  def update
  @application = RegisteredApplication.find(params[:id])
  @application.title = params[:application][:title]
  @application.url = params[:application][:url]

  if @application.save
    flash[:notice] = " Application was updated."
    redirect_to @application
  else
    flash.now[:alert] = "There was an error saving the application. Please try again."
    render :edit
  end
end

def destroy
  @application = RegisteredApplication.find(params[:id])

  if @application.destroy
    flash[:notice] = "\"#{@application.title}\" was deleted successfully."
     redirect_to registered_applications_path
   else
     flash.now[:alert] = "There was an error deleting the application."
     render :show
   end
end

  private

  def application_params
    params.require(:registered_application).permit(:title, :url)
  end
end
