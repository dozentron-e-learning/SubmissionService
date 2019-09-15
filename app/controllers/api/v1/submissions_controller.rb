class Api::V1::SubmissionsController < ApplicationController
  before_action :set_submission, only: [:show, :update, :destroy, :download]

  # GET /submissions
  def index
    @submissions = Api::V1::Submission.all

    render json: @submissions
  end

  # GET /submissions/1
  def show
    render json: @submission
  end

  # POST /submissions
  def create
    @submission = Api::V1::Submission.new(submission_params)
    @submission.auth_token = @token

    if @submission.save
      render json: @submission, status: :created, location: @submission
    else
      render json: @submission.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /submissions/1
  def update
    if @submission.update(submission_params)
      render json: @submission
    else
      render json: @submission.errors, status: :unprocessable_entity
    end
  end

  # DELETE /submissions/1
  def destroy
    @submission.destroy
  end

  def download
    send_file @submission.file.path
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_submission
    @submission = Api::V1::Submission.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def submission_params
    params.fetch(:submission, {}).permit Api::V1::Submission::STRONG_PARAMETERS
  end
end
