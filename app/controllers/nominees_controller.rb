class NomineesController < ApplicationController
  layout :custom_layout
  # GET /nominees
  # GET /nominees.json


   def index
      
     @nominees = Nominee.all
     @vote_settings = current_user.vote_setting
     
      respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @nominees }
      
      @searchuser ||= []
        @adminusers = User.find_all_by_admin_user_id(current_user.id, :conditions => ["firstname || lastname || fullname LIKE ?", "%#{params[:search]}%"])
        @adminusers.each do |adminuser|
        fullname = adminuser.fullname
        @searchuser << fullname
       end
       @searchuser
      
    end
  end


  def toggled_status
        @nominees = User.find(params[:id])
        @nominees.status = !@nominees.status?
        @nominees.save!
        redirect_to nominees_path
  end

  # GET /nominees/1
  # GET /nominees/1.json
  def show
    @nominee = Nominee.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @nominee }
    end
  end

  # GET /nominees/new
  # GET /nominees/new.json
  def new
    @nominee = Nominee.new
    @searchuser ||= [] 

    @adminusers = User.where(["firstname || lastname || fullname LIKE ? and id != ? and admin_user_id =? and admin_user_id is not null", "%#{params[:search]}%",current_user.id,current_user.id])

        @adminusers.each do |adminuser|
          fullname = adminuser.fullname + adminuser.email
          @searchuser << fullname
        end

        @searchuser 

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @nominee }
    end
  end

  # GET /nominees/1/edit
  def edit
    @nominee = Nominee.find(params[:id])
  end

  # POST /nominees
  # POST /nominees.json
  def create
      nominee_params = params[:nominee][:user_id]
      nominee_split = nominee_params.split(" ")

      nominee_fullname = nominee_split[0] + " " + nominee_split[1] rescue nil

      nominee_email = nominee_split[2]
      nominee = User.where(["fullname LIKE ? and email LIKE ?", "%#{nominee_fullname}%","%#{nominee_email}%"])
      user_id = nominee[0].id
      email = nominee[0].email
      fullname = nominee[0].fullname
      firstname = nominee[0].firstname
      lastname = nominee[0].lastname
      @nominee = Nominee.new(params[:nominee])   
      @nominee.user_id = user_id
      @nominee.email = email
      @nominee.fullname = fullname
      @nominee.firstname = firstname
      @nominee.lastname = lastname 

     
    if  nominee_params.present? 

      if @nominee.save
       flash[:success] = "Vote for this user successfully submitted."
       redirect_to :back
    
      else
        redirect_to :back, :notice=> "Take a time to fill all the below records.."
      end
    end  
end


  # PUT /nominees/1
  # PUT /nominees/1.json
   
  def update
    @nominee = Nominee.find(params[:id])

    respond_to do |format|
      if @nominee.update_attributes(params[:nominee])
        format.html { redirect_to @nominee, notice: 'Nominee was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @nominee.errors, status: :unprocessable_entity }
      end
    end
  end

  

  # DELETE /nominees/1
  # DELETE /nominees/1.json
  def destroy
    @nominee = Nominee.find(params[:id])
    @nominee.destroy
    flash[:success] = "User successfully removed from nominations."
    respond_to do |format|
      format.html { redirect_to nominees_url }
      format.json { head :no_content }
    end
  end


# def check_email
#     @nominee = Nominee.find_by_email(params[:nominee][:email])
#     respond_to do |format|
    
#     format.json { render :json => !@nominee }

#   end
# end


def custom_layout
        case action_name
         when "edit"
          "profile" 
         when "new"
          "profile" 
         when "show"
          "profile" 
         when "index"
          "profile"  
          
         else
          "application"
        end
    end
    

end
