module Admin
  # app/controllers/admin/tutorials_controller.rb
  class TutorialsController < Admin::BaseController
    def edit
      @tutorial = Tutorial.find(params[:id])
    end

    def create
      tutorial = Tutorial.create(tutorial_params)
      if tutorial.save
        flash[:success] = 'Successfully created tutorial.'
        redirect_to tutorial_path(tutorial.id)
      else
        flash[:error] = 'Tutorial was not created.'
        redirect_to new_admin_tutorial_path
      end
    end

    def new
      @tutorial = Tutorial.new
    end

    def update
      tutorial = Tutorial.find(params[:id])
      if tutorial.update(tutorial_params)
        flash[:success] = "#{tutorial.title} tagged!"
      end
      redirect_to edit_admin_tutorial_path(tutorial)
    end

    def destroy
      tutorial = Tutorial.find(params[:id])
      tutorial.destroy
      redirect_to admin_dashboard_path
    end

    private

    def tutorial_params
      params.require(:tutorial)
            .permit(:tag_list, :title, :description, :thumbnail)
    end
  end
end
