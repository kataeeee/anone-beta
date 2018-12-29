class InquiriesController < ApplicationController
  def new

  end

  def create
    #基本質問
    @basic = Basic.new(
        user_id: current_user.id,
        q1_sex: params[:q1_sex],
        q2_sexual_orientation: params[:q2_sexual_orientation],
        q3_gender: params[:q3_gender],
        q4_partner: params[:q4_partner],
        q5_sexual_experience: params[:q5_sexual_experience],
        b_type_person: params[:b_type_person],
        b_partner_attribute: params[:b_partner_attribute]
    )
    @basic.save

    #こころの性
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

    #恋愛的指向
    if params[:q_self_gender] == "男" && params[:q_self_gender] == params[:b_partner_attribute]
      current_user.romantic_result_1 = "ゲイ"
    elsif params[:q_self_gender] == "女" && params[:q_self_gender] == params[:b_partner_attribute]
      current_user.romantic_result_1 = "レズビアン"
    elsif params[:q2_sexual_orientation] == "1" and params[:b_partner_attribute] == "両性" || "その他"
      current_user.romantic_result_1 = "バイロマンティック"
    elsif params[:q2_sexual_orientation] == ("2" || "3") and params[:b_partner_attribute] == ("両性" || "その他") and params[:b_type_person] == ("3" || "4")
      current_user.romantic_result_1 = "オムニセクシャル"
    elsif params[:q2_sexual_orientation] == ("2" || "3") and params[:b_partner_attribute] == ("両性" || "その他") and params[:b_type_person] == ("1" || "2")
      current_user.romantic_result_1 = "パンロマンティック"
    elsif params[:q2_sexual_orientation] == "4" and params[:b_partner_attribute] == ("両性" || "その他") and params[:b_type_person] == ("1" || "2") and params[:r_13].include?("3") || params[:r_13].include?("4")
      current_user.romantic_result_1 = "パンロマンティック"
    else
      current_user.romantic_result_1 = ""
    end

    if params[:r_14].to_i == 4 && params[:r_16].to_i == 4
      current_user.romantic_result_2 = "クォイロマンティック"
    else
      lith_score = params[:q4_partner][0].to_i + params[:r_1].to_i + params[:r_2].to_i + params[:r_3].to_i + params[:r_4].to_i
      a_score = params[:q4_partner][1].to_i + params[:r_4].to_i + params[:r_5].to_i + params[:r_6].to_i + params[:r_7].to_i
      demi_score = params[:q4_partner][2].to_i + params[:r_8].to_i + params[:r_9].to_i + params[:r_10].to_i + params[:r_11].to_i
      polyamory_score = params[:q4_partner][3].to_i + (params[:r_14].to_i + params[:r_15].to_i + params[:r_16].to_i) * 4/3
      gyne_andro_score = params[:q4_partner][4].to_i * 20
      array = [lith_score, a_score, demi_score, polyamory_score, gyne_andro_score]
      max = array.max
      if array.index(max) == 0
        current_user.romantic_result_2 = "リスロマンティック"
      elsif array.index(max) == 1
        current_user.romantic_result_2 = "アロマンティック"
      elsif array.index(max) == 2
        current_user.romantic_result_2 = "デミロマンティック"
      elsif array.index(max) == 3
        current_user.romantic_result_2 = "ポリアモリーロマンティック"
      else
        current_user.romantic_result_2 = "ガイネ・アンドロセクシャル"
      end
    end

    #性的指向
    if params[:q_self_gender] == "男" && params[:q_self_gender] == params[:b_sex_attribute]
      current_user.sexual_result_1 = "ゲイ"
    elsif params[:q_self_gender] == "女" && params[:q_self_gender] == params[:b_sex_attribute]
      current_user.sexual_result_1 = "レズビアン"
    elsif params[:b_sex_attribute] == ("両性" || "その他") && params[:s_10] == ("3" || "4")
      current_user.sexual_result_1 = "バイセクシャル"
    elsif params[:b_sex_attribute] == ("両性" || "その他") && params[:s_10] == ("1" || "4")
      current_user.sexual_result_1 = "パンセクシャル"
    else
      current_user.sexual_result_1 = ""
    end

    if params[:s_1].to_i == 4
      current_user.sexual_result_2 = "フレイセクシャル"
    else
      lith_se_score = (params[:s_11].to_i + params[:s_12].to_i + params[:q5_sexual_experience][0].to_i)/3
      a_se_score = (params[:s_7].to_i + params[:s_8].to_i + params[:q5_sexual_experience][1].to_i)/3
      demi_se_score = (params[:s_6].to_i + params[:s_7].to_i + params[:s_8].to_i + params[:q5_sexual_experience][2].to_i)/4
      sapio_se_score = (params[:s_2].to_i + params[:s_3].to_i + params[:s_4].to_i + params[:s_5].to_i)/4
      gyne_andro_se_score = params[:q5_sexual_experience][5].to_i
      array = [lith_se_score, a_se_score, demi_se_score, sapio_se_score, gyne_andro_se_score]
      max = array.max
      if array.index(max) == 0
        current_user.sexual_result_2 = "リスセクシャル"
      elsif array.index(max) == 1
        current_user.sexual_result_2 = "アセクシャル"
      elsif array.index(max) == 2
        current_user.sexual_result_2 = "デミセクシャル"
      elsif array.index(max) == 3
        current_user.sexual_result_2 = "フレイセクシャル"
      elsif array.index(max) == 4
        current_user.sexual_result_2 = "サピオアンドロセクシャル"
      else
        current_user.sexual_result_2 = "ガイネ・アンドロセクシャル"
      end
    end

    current_user.save

    #表現したい性

    redirect_to("/")

  end

  def edit

  end
end