class InquiriesController < ApplicationController
  def new
  end

  def create
    @basic = Basic.new(
                      user_id: current_user.id,
                      q1_sex: params[:q1_sex],
                      q2_sexual_orientation: params[:q2_sexual_orientation],
                      q3_gender: params[:q3_gender],
                      q4_partner: params[:q4_partner],
                      q5_sexual_experience: params[:q5_sexual_experience]
    )
    @basic.save

    redirect_to("/")

  end

  def edit

  end
end