class MembersController < ApplicationController
  before_action :set_member, only: [:show, :edit, :destroy]

  # GET /members
  # GET /members.json
  def index
    @members = Member.all
  end

  # GET /members/1
  # GET /members/1.json
  def show
  end

  # GET /members/new
  def new
    @user = User.new
    @member = @user.build_member
  end

  # GET /members/1/edit
  def edit
    respond_to do |format|
      format.html
      format.js{render action: 'new'}
    end
  end

  # POST /members
  # POST /members.json
  def create
    @user = User.new(user_params)

    
    respond_to do |format|
      if @user.save
        @members = Member.all
        format.html { redirect_to @user.member, notice: 'Member was successfully created.' }
        format.js
      else
        format.html { render action: 'new' }
        format.js { render action: 'new' }
      end
    end
  end

  # PATCH/PUT /members/1
  # PATCH/PUT /members/1.json
  def update
    @user = User.find(params[:id])
    @member = @user.member
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @member, notice: 'Member was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /members/1
  # DELETE /members/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to members_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = Member.find(params[:id])
      @user = @member.user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def member_params
      params.require(:member).permit(:first_name, :last_name, :user_id, :title, :note)
    end

    def user_params
      params.require(:user).permit(:email, :password, member_attributes: [:id, :first_name, :last_name, :title, :note, :_destroy])
    end
end
