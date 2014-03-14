class NomineesController < ApplicationController
  layout :custom_layout
  # GET /nominees
  # GET /nominees.json


  def index
      
     @nominees = Nominee.all
     @vote_settings = VoteSetting.all
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
    @nominee = Nominee.new(params[:nominee])

    
      if @nominee.save
        redirect_to nominees_path
      else
        render :new
      
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
