class AuthorsController < ApplicationController

	def full_name
	@author = Author.find(params[:id])
	render :json => [@author.last_name + " " + @author.first_name]
	end
	
  # GET /authors
  # GET /authors.json
  def index
    @authors = Author.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @authors }
    end
  end

  # GET /authors/1
  # GET /authors/1.json
  def show
    @author = Author.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @author }
    end
  end

  # GET /authors/new
  # GET /authors/new.json
  def new
    @author = Author.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @author }
    end
  end

  # GET /authors/1/edit
  def edit
    @author = Author.find(params[:id])
  end

  # POST /authors
  # POST /authors.json
  def create
    @author = Author.new(params[:author])
    @author.project_id = current_user.project_id
    @author.user_id = current_user.id

    respond_to do |format|
      if @author.save
      	
        format.html { redirect_to root_path(tab:"newaut",:author => @author) }
        flash[:notice] = ("Author " + @author.first_name + " " + @author.last_name + " has been added")
        format.json { render json: @author, status: :created, location: @author }
      else
        format.html { render  :partial => "dashboard/newauthor", :author => @author }
        format.json { render json: @author.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /authors/1
  # PUT /authors/1.json
  def update
    @author = Author.find(params[:id])
    respond_to do |format|
      if @author.update_attributes(params[:author])
        format.html { redirect_to @author, notice: 'Author was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @author.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /authors/1
  # DELETE /authors/1.json
  def destroy
    @author = Author.find(params[:id])
    myAuthor = @author.first_name + @author.last_name
    @author.destroy
    respond_to do |format|
    	flash[:notice] = ("Author " + myAuthor + " has been deleted")
      format.html { redirect_to root_path(tab:"authorlist") }
      format.json { head :no_content }
    end
  end
  
  def create_author
    puts "Inside Author controller with create_author"
    @a = params[:author]
    @author = Author.new()
    @author.first_name = @a[:first_name]
    @author.last_name = @a[:last_name]
    newauthor = !Author.where(:first_name => @author.first_name,:last_name => @author.last_name ).exists?
    if newauthor= true
      @author.save
      flash[:notice] = ("Author " + @author.first_name + " " + @author.last_name + " has been added")
    else
      flash[:notice] = ("Author " + @author.first_name + " " + @author.last_name + " already exists")
    end
  end
    rescue_from CanCan::AccessDenied do |exception|
    redirect_to authors_url, :alert => exception.message
  end
  
end
