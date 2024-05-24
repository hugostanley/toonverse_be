class Api::V1::JobsController < ApplicationController
  before_action :authenticate_workforce!
  before_action :set_job, except: %i[index create]

  def index
    @jobs = if current_workforce.admin?
              Jobs.includes(:order, :workforce).all.order(created_at: :desc)
            else
              current_workforce.jobs ? [current_workforce.jobs] : []
            end

    jobs = @jobs.map do |job|
      {
        id: job.id,
        order_id: job.order_id,
        workforce_id: job.workforce_id,
        claimed_at: job.claimed_at,
        commission: job.commission,
        created_at: job.created_at,
        updated_at: job.updated_at,
        status: job.order.order_status,
        email: job.workforce.email
      }
    end

    render json: jobs, status: :ok
  end

  def show
    render json: {
             job: @job.as_json.merge(email: @job.workforce.email, status: @job.order.order_status)
           },
           status: :ok
  end

  private

  def set_job
    @job = Job.includes(:workforce, :order).find(params[:id])

    unless @job.workforce_id == current_workforce.id || current_workforce.admin?
      render json: {
               message: 'You are not authorized to access this profile'
             },
             status: :unauthorized
    end
  rescue ActiveRecord::RecordNotFound
    render json: {
             error: 'Artist profile not found'
           },
           status: :not_found
  end

  def job_params
    params.require(:job).permit(:first_name, :last_name, :billing_address, :bio, :mobile_number)
  end

  def jobs_params
    params.permit(:email, :password, :password_confirmation)
  end
end
