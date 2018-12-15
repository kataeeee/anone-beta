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

    @gender = Gender.new(
        user_id: current_user.id,
        q6_gender_fitting: params[:q6_gender_fitting],
        q7_body_fitting: params[:q7_body_fitting],
        q8_favorite_dress: params[:q8_favorite_dress],
        q9_choose_middle: params[:q9_choose_middle],
        q10_personal_time: params[:q10_personal_time],
        q11_sensibility: params[:q11_sensibility],
        q12_behavior_adjusting: params[:q12_behavior_adjusting],
        q13_group_comfort: params[:q13_group_comfort]
    )
    @gender.save

    if params[:q3_gender].to_i == 4 && params[:q7_body_fitting].to_i <= 2
      current_user.gender_result = "シスジェンダー"
    elsif params[:q3_gender].to_i <= 2 && params[:q7_body_fitting].to_i >= 3
      current_user.gender_result = "トランスジェンダー"
    else
      current_user.gender_result = "Xジェンダー"
    end

    current_user.save

    redirect_to("/")

  end

  def edit

  end
end