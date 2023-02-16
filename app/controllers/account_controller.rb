class AccountController < ApplicationController
  def signup
    @user = User.new
    if request.post?
      @user = User.new(user_params)
      if @user.save
        UserNotifierMailer.signup_alert(@user).deliver
        redirect_to :action=> "login"
      else
        render :action=> "signup"
      end
    end
  end

  def login
    if request.post?
      @user = User.authenticate(params[:email], params[:password])

      if @user
        session[:user] = @user.id
        redirect_to :action=> :dashboard
      else
        flash[:notice] = "Invalid email or password"
        render :action => "login"
      end
    end
  end

  def logout
    session.delete(:user)
    flash[:notice] ="Successfully logged out"
    redirect_to account_login_url
  end

  def forget_password
    if request.post?
      @user = User.find_by_email(params[:email])

      if @user
        new_password = create_random_password
        @user.update(:password=>new_password)

        UserNotifierMailer.forget_password_alert(@user).deliver
        # config.filter_parameters << :new_password

        # puts "############## ese to ye password log(teminal) mei bhi show ho rha hei , ye secure thodi tha, use this(config.filter_parameters << :password )"
        # puts new_password 
        redirect_to account_login_url
      else
        flash[:notice] ="Email not identified"
        render :action=> :forget_password
      end
    end
  end

  def create_random_password
    (0...6).map { (65 + rand(26)).chr }.join
  end

  def reset_password
    @user = User.find(session[:user])
    if @user
      unless params[:password].nil? || params[:password] == "" || params[:password]== nil
        @user.update(:password => params[:password])

        flash[:notice] ="Password is successfully updated."
        redirect_to account_dashboard_url
      else
        flash[:notice] = "Please enter valid password."
        render :action => :reset_password
      end
    end
  end

  def edit_profile
    @user = User.find(session[:user])
    if request.post?
      if @user.update(edit_profile_params)
        flash[:notice] ="Successfully updated"
        redirect_to account_dashboard_url
      else
        flash[:notice] = "Update unsuccessful"
        render :action => :edit_profile
      end
    end
  end

  def user_params
    params.permit(:first_name, :last_name, :date_of_birth,:date_of_birth, :mobile, :password, :encrypted_password, :password_confirmation)
  end

  def edit_profile_params
    params.permit(:first_name, :last_name, :date_of_birth, :mobile)
  end
end
