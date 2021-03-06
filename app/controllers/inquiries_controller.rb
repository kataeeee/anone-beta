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
        b_partner_attribute: params[:b_partner_attribute],
        q_self_gender: params[:q_self_gender],
        b_sex_attribute: params[:b_sex_attribute]
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
    @romantic = Romantic.new(
        r_1:params[:r_1],
        r_2:params[:r_2],
        r_3:params[:r_3],
        r_4:params[:r_4],
        r_5:params[:r_5],
        r_6:params[:r_6],
        r_7:params[:r_7],
        r_8:params[:r_8],
        r_9:params[:r_9],
        r_10:params[:r_10],
        r_11:params[:r_11],
        r_13:params[:r_13],
        r_14:params[:r_14],
        r_15:params[:r_15],
        r_16:params[:r_16]
    )
    @romantic.save

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
        current_user.romantic_result_2 = "ポリアモリー"
      else
        current_user.romantic_result_2 = "ガイネ・アンドロセクシャル"
      end
    end

    #性的指向
    @sexual = Sexual.new(
        s_1:params[:s_1],
        s_2:params[:s_2],
        s_3:params[:s_3],
        s_4:params[:s_4],
        s_5:params[:s_5],
        s_6:params[:s_6],
        s_7:params[:s_7],
        s_8:params[:s_8],
        s_9:params[:s_9],
        s_10:params[:s_10],
        s_11:params[:s_11],
        s_12:params[:s_12]
    )
    @sexual.save

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
        current_user.sexual_result_2 = "サピオセクシャル"
      else
        current_user.sexual_result_2 = "ガイネ・アンドロセクシャル"
      end
    end

    #表現したい性
    cis_ap_score = (params[:q6_gender_fitting][0].to_i*2 + params[:q10_personal_time][0].to_i + params[:q12_behavior_adjusting][0].to_i*2)/4
    trans_ap_score = (params[:q6_gender_fitting][1].to_i*2 + params[:q10_personal_time][1].to_i + params[:q12_behavior_adjusting][1].to_i*2)/4
    x_ap_score = (params[:q6_gender_fitting][2].to_i*2 + params[:q10_personal_time][2].to_i + params[:q11_sensibility][2].to_i/2 + params[:q12_behavior_adjusting][2].to_i*2 + params[:q13_group_comfort][2].to_i*2)/6
    if params[:q1_sex] != params[:q8_favorite_dress]
      cis_ap_score += 2/4
    elsif params[:q1_sex] != params[:q8_favorite_dress]
      trans_ap_score += 2/6
    elsif params[:q8_favorite_dress] == "両性"
      x_ap_score += 2/4
    end
    array = [cis_ap_score, trans_ap_score,x_ap_score]
    max = array.max
    if array.index(max) == 0
      current_user.appearance_result = "シスジェンダー"
    elsif array.index(max) == 1
      current_user.appearance_result = "トランスジェンダー"
    elsif array.index(max) == 2
      current_user.appearance_result = "Xジェンダー"
    end

    current_user.save

    #全体での割合
    ratio_gender = User.where(gender_result: current_user.gender_result).count/User.all.count
    ratio_romantic_1 = User.where(romantic_result_1: current_user.romantic_result_1).count/User.all.count
    ratio_romantic_2 = User.where(romantic_result_2: current_user.romantic_result_2).count/User.all.count
    ratio_sexual_1 = User.where(sexual_result_1: current_user.sexual_result_1).count/User.all.count
    ratio_sexual_2 = User.where(sexual_result_2: current_user.sexual_result_2).count/User.all.count
    ratio_appearance = User.where(appearance_result: current_user.appearance_result).count/User.all.count

    current_user.ratio_gender = ratio_gender.truncate(3)*100
    current_user.ratio_romantic_1 = ratio_romantic_1.truncate(3)*100
    current_user.ratio_romantic_2 = ratio_romantic_2.truncate(3)*100
    current_user.ratio_sexual_1 = ratio_sexual_1.truncate(3)*100
    current_user.ratio_sexual_2 = ratio_sexual_2.truncate(3)*100
    current_user.ratio_appearance = ratio_appearance.truncate(3)*100

    current_user.save

    redirect_to("/")
  end

  def edit

  end

  def update

  end
end