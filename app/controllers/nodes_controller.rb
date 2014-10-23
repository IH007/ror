# This controller inherits from SecuredController. SecuredController uses
# Devise to make sure that the user is authenticated prior to invoking the
# specified actions

###WORKING

class NodesController < SecuredController

  before_filter only: [:new, :index, :create, :edit, :update] do

    puts "xxxxxxxxxxxx"
    @node_types     = Lookup.where(lookup_type: 'node')
    @node_attrtypes = Lookup.where(lookup_type: 'nodeattr')
  end

  # Retrieves all the nodes and responds to the URL /nodes (GET verb)
  # renders the view /views/nodes/index.html.erb by default
  def index
    @nodes = Node.paginate(page: params[:page])
    #byebug
  end

  # Retrieves a single Node by id and responds to the URL /nodes/:id (GET Verb)
  # renders the view /views/nodes/show.html.erb by default
  def show
    id = params[:id]
    @node = Node.find(id)
  end

  # Renders the new form for adding an Node to the system
  # @Node is used in the form for the binding process
  def new
    # @node = Node.new # orig 
    
    @node = Node.new
    @node.node_attrbs.build

   

  end

  # Takes the nodes details and persists it to the database
  def create
    # Whitelisting is used to secure our actions from processing un-identified
    # parameters sent in the http request, this is a new Rails 4 feature
    #@node = Node.new(white_listed_params)
    @node = Node.new(params[:node])

    #@salary_report = SalaryReport.new(salary_report_params)
    
    if @node.save
      flash[:success] = "Node #{@node.name_display} saved successfully."
      # nodes_path is a helper that uses routes.rb to return
      # a string like '/nodes'.
      # redirect_to  is a function that takes the relative url
      # and sends a 302 redirect to the browser
      redirect_to nodes_path
    else
      render :new
    end
  end

  # Find the corresponding Node and then render the edit form
  def edit
    @node = Node.find(params[:id])
  end

  def update
    @node = Node.find(params[:id])
    #byebug
    # if @node.update_attributes(white_listed_params)
    #   #@user.update_attributes(params[:user])

    @node.update_attributes(params[:node])

    puts "XXXXXXXXXXXXXXXXXXXXX  @node.update_attributes(params[:node])"

    flash[:success] = "Node #{@node.name_display} updated successfully."
    redirect_to nodes_path


    # else
    #   render :edit
      
    # end
 
###### work on later #####################
 #  if 
    # urlp = "www.google.com"
    # pageranking(urlp)

    # url = 'google.com'
    # x = shorten_with_bitly(url)

#################################################


  end

  def destroy
# byebug
    @node = Node.find_by_id(params[:id])
    @node.destroy if @node
    redirect_to nodes_path

      # @nodeattr = @node(params[:node])
      # @nodeattr.delete if @nodeattr
  end

#private

  def white_listed_params
    params.require(:node).permit(:name_display, :node_type_id)
  end





################################
  def shorten_with_bitly(url)

   require 'open-uri'
   require 'json'
   #byebug
   #open("http://www.ruby-lang.org/en/",
   # "User-Agent" => "Ruby/#{RUBY_VERSION}",
   #"From" => "foo@bar.invalid",
   #{}"Referer" => "http://www.ruby-lang.org/")



    # build url to bitly api
    url = "http%3A%2F%2Fgoogle.com%2F"
    urlc ="http://google.com/"
    user = "ih007"
    apikey = "R_71e9c313478b4fbe9176e8303516f280"
    version = "2.0.1"

    bitly_url = "http://api.bit.ly/shorten?version=#{version}&longUrl=#{url}&login=#{user}&apiKey=#{apikey}" 
    #bitly_url = "http://api.bit.ly/v3/shorten?longUrl=#{url}&login=#{user}&apiKey=#{apikey}&format=txt"
    
    # parse result and return shortened url
   
    #shorten_url = open(bitly_url, "UserAgent" => "Ruby-ExpandLink").read

    buffer = open(bitly_url, "UserAgent" => "Ruby-ExpandLink").read
    #
    result = JSON.parse(buffer)
    #
    short_url = result["results"][urlc]["shortUrl"]
    x=1
    x=2
    puts "################## Bitly ##############"
    puts short_url
    #@nodes = Node.paginate(page: params[:page])
  end

  def pageranking(urlp)
    require 'page_rankr'

    urlp = "www.google.com"
    
    p = PageRankr.ranks(urlp, :google)

    puts "################## page rank ##############"
    puts p

  end

##############################################################







end

