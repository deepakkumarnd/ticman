class RegistrationsController < ApplicationController
  # organization registration

  def new
    @user = User.new
  end

  def create
    @user = User.new(registration_params.merge(role: 'admin'))

    if @user.save
      # First user will be the admin user of the organization
      # he will have to click the email confirmation to activate
      # organization account.
      @user.send_confirmation_email!
    else
      render 'new'
    end
  end

  private

  def registration_params
    params.require(:user).permit(:name, :organization_name)
  end
end