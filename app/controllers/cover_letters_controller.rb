class CoverLettersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cover_letter

  def index
  end

  def edit
  end

  def update
    if @cover_letter.update(cover_letter_params)
      redirect_to edit_cover_letter_path(@cover_letter), notice: 'Your Cover Letter has been saved'
    else
      render :edit
    end
  end

  private

  def set_cover_letter
    @cover_letter = current_user.cover_letter
  end

  def cover_letter_params
    params[:cover_letter].permit(:body)
  end
end
