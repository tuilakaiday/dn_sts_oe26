class Admin::CoursesController < AdminController
  before_action :load_params, only: :index
  before_action :load_course, only: [:destroy, :start, :finish]
  def index
    @courses = Course.load_courses(@status).order_by.paginate(page: @page,
      per_page: Settings.per_page)
  end

  def destroy
    if @course.destroy
      flash[:info] = t(".delete_success", name: @course.name)
    else
      flash[:info] = t(".delete_fail", name: @course.name)
    end
    redirect_to request.referrer
  end

  def start
    if (_admin? || _trainer?) && @course.archive?
      @course.start_course
      flash[:success] = t ".success_start"
    else
      flash[:danger] = t ".fails_start"
    end
    redirect_to request.referrer
  end

  def finish
    if (_admin? || _trainer?)
      @course.finish_course
      flash[:success] = t ".success_finish"
    else
      flash[:danger] = t ".fails_finish"
    end
    redirect_to request.referrer
  end

  private

  def load_course
    @course = Course.find_by(id: params[:id])
    return if @course
    return "shares/not_found"
  end

  def load_params
    @page = params[:page]
    @status = params[:status]
  end
end
