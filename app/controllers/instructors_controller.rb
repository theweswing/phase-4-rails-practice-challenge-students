class InstructorsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_input
  def index
    render json: Instructor.all, status: :ok
  end

  def show
    found_instructor = Instructor.find(params[:id])
    render json: found_instructor, status: :ok
  end

  def create
    new_instructor = Instructor.create!(strong_params)
    render json: new_instructor, status: :created
  end

  def update
    found_instructor = Instructor.find(params[:id])
    found_instructor.update!(strong_params)
    render json: found_instructor, status: :accepted
  end

  def destroy
    found_instructor = Instructor.find(params[:id])
    found_instructor.destroy
    head :no_content
  end

  private

  def strong_params
    params.permit(:name)
  end

  def invalid_input(e)
    render json: {
             errors: e.record.errors.full_messages,
           },
           status: :unprocessable_entity
  end

  def not_found
    render json: { error: 'Instructor Not Found!' }, status: :not_found
  end
end
