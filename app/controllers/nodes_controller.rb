# This controller inherits from SecuredController. SecuredController uses
# Devise to make sure that the user is authenticated prior to invoking the
# specified actions

###WORKING

class NodesController < SecuredController
  puts "xxxxxxx NodesC a:new xxxxxxx"
  require 'uri'
  #require 'url_validator'

  # class Urlvalidtor
  #   attr_accessor :website
  #   validates_url :website
  # end

 # attr_accessor :name_display

  before_filter only: [:new, :index, :create, :edit, :update] do
  @node_types     = Lookup.where(lookup_type: 'node')
  @node_attrtypes = Lookup.where(lookup_type: 'nodeattr')
  end

  # Retrieves all the nodes and responds to the URL /nodes (GET verb)
  # renders the view /views/nodes/index.html.erb by default
  def index
    puts "xxxxxxx NodesC a:index xxxxxxx"
    @nodes = Node.paginate(page: params[:page])
    #byebug
  end

  # Retrieves a single Node by id and responds to the URL /nodes/:id (GET Verb)
  # renders the view /views/nodes/show.html.erb by default
  def show
    # puts "xxxxxxx NodesC a:show xxxxxxx"
    # id = params[:id]
    # @node = Node.find(id)

    puts "xxxxxxx NodesC a:show NEW xxxxxxx"
    @node = Node.new
    #@node.node_attrbs.build
    #byebug
  end

  # Renders the new form for adding an Node to the system
  # @Node is used in the form for the binding process
  def new
    puts "xxxxxxx NodesC a:new xxxxxxx"
    # @node = Node.new # orig 
    
    @node = Node.new
    #@node.build ==> this does not work as there is m
    #@node.node_attrbs.build
    #byebug
  end

  # Takes the nodes details and persists it to the database
  def create
    puts "xxxxxxx NodesC a:create xxxxxxx"
    # Whitelisting is used to secure our actions from processing un-identified
    # parameters sent in the http request, this is a new Rails 4 feature
    #@node = Node.new(white_listed_params)

    puts "1XXXXXXX params:", params, " ...YYYYYYYYYYYYY"
    puts "2XXXXXXX params[:node]:", params[:node], " ...YYYYYYYYYYYYY"
    puts "3XXXXXXX params[:node][:name_display]:",params[:node][:name_display], " ...YYYYYYYYYYYYY"

    @node = Node.new(params[:node])   
    @node.user_id = current_user.id
    
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
    puts "4XXXXXXX @node.to_yaml", @node.to_yaml , "... this is an object YYYYYYYYYYYY"
    puts "5XXXXXXX @node.user_id.inspect", @node.user_id.inspect , "... object property YYYYYYYYYYYYYYYY"
  end

  # Find the corresponding Node and then render the edit form
  def edit #$$~used
    puts "xxxxxxx NodesC a:edit  xxxxxxx"
    @node = Node.find(params[:id])
  end

  def update #$$~used
    puts "xxxxxxx NodesC a:update xxxxxxx"
    @node = Node.find(params[:id])
    puts "PPPPPPP params ", params, "RRRRRRRRRRYYYYYYYYYY"
    #byebug
    
    #if @node.update_attributes(white_listed_params)

    @node.update_attributes(params[:node])

    puts "2XXXXXXXXXXXXXXXXX executed @node.update_attributes(params[:node]) ... above"
    puts "3XXXXXXXXXXXXXXXXX params[:node] ", params[:node], "YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY"
    #puts "1XXXXXXXXXXXXXXXXX @node.attributes(params[:node]) ", @node.attributes(params[:node]), "YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY"
    puts "66666666666666666666666   @node.node_attrbs.each do |n|  6666666666666666666666666666666"
    puts

    #@node.node_attrbs.first.name = "help me save"
    #@node.node_attrbs.first.save

    @node.node_attrbs.each do |n|
      if n.node_type_id == 4 #@@ logic inderaction needs to be added
        puts 
        puts "NNNNNNNN", n.id.to_s,n.name,  n.node_type_id.to_s,  "YYYYYYYYYYY" 
        #byebug

        urlcheck = n.name
        urltest = url_valid?(urlcheck)
        #byebug 
        if urltest
          n.url_short = shorten_with_bitly(urlcheck)
          n.url_rank =  pageranking(urlcheck)
        else
          n.url_rank = nil
          n.url_short = "URL not valid"
        end 
      else
          n.url_rank = nil
          n.url_short = nil
      end
       n.save
    end

      #puts "XXXXXX @node.node_attrbs[:name].to_yaml  ", @node.node_attrbs[:name].to_yaml, "YYYYY  this is an object YYYYYYYYYYYY"
      #puts "4XXXXXX @node.node_attrbs.name.first   ",  @node.node_attrbs.first.name, "YYYYYYYYY"
      #puts "4XXXXXX @node.node_attrbs.name.second  ",  @node.node_attrbs.second.name, "YYYYYYYYY"
      #@node.update_attributes(:url_short, "goole.com")
      #@node.attributes.name_display = "goole.com"
    puts "4XXXXXX @node.to_yaml  ",  @node.to_yaml, "YYYYYYYY"
      #puts "4XXXXXX @node.node_attrbs  ",  @node.node_attrbs, "YYYYYYYYY"
      #puts "5XXXXXX @node.node_attrbs([:name])  ", @node.node_attrbs([:name]), "....YYYYYYYYYYYY"
      #puts "5XXXXXX @node.node_attrbs([:name].to_yaml)  ", @node.node_attrbs([:name]).to_yaml, "YYYYYYYYYYYY"
      #puts "6XXXXXX @node.node_attrbs.to_yaml  ", @node.node_attrbs.to_yaml, "YYYYY  this is an object YYYYYYYYYYYY"
    puts "7XXXXXXX debug @node.node_attrbs.inspect ", @node.node_attrbs.inspect , "YYYY object property YYYYYYYYYYYYYYYY"
    
    flash[:success] = "Node #{@node.name_display} updated successfully."
    
    if params[:xxxx]
      render :edit 
    else 
      redirect_to nodes_path
    end
  

  end

  def destroy
    puts "xxxxxxx NodesC a:destroy xxxxxxx"
    # byebug
    @node = Node.find_by_id(params[:id])
    @node.destroy if @node
    redirect_to nodes_path

      # @nodeattr = @node(params[:node])
      # @nodeattr.delete if @nodeattr
  end

#private
###############################################################
  def white_listed_params
    puts "xxxxxxx NodesC white_list params xxxxxxx"
    #params.require(:node).permit(:name_display, :node_type_id)
  end

#############################################################
   
  def url_valid?(url)
    puts "################## url_valid?(url) ##############"
    url = URI.parse(url) rescue false
    url.kind_of?(URI::HTTP) || url.kind_of?(URI::HTTPS)
  end 

#############################################################
  
  def shorten_with_bitly(urlc)
    puts "################## Bitly ##############"

    require 'open-uri'
    require 'json'
  
    #open("http://www.ruby-lang.org/en/",
    #"User-Agent" => "Ruby/#{RUBY_VERSION}",
    #"From" => "foo@bar.invalid",
    #{}"Referer" => "http://www.ruby-lang.org/")

    # build url to bitly api
      
    user = "ih007"
    apikey = "R_71e9c313478b4fbe9176e8303516f280"
    version = "2.0.1"

    #urlc = "http://google.com/"
    #url = "http%3A%2F%2Fgoogle.com%2F"
    url = URI.encode(urlc)

    bitly_url = "http://api.bit.ly/shorten?version=#{version}&longUrl=#{url}&login=#{user}&apiKey=#{apikey}" 
    #bitly_url = "http://api.bit.ly/v3/shorten?longUrl=#{url}&login=#{user}&apiKey=#{apikey}&format=txt"
    
    # parse result and return shortened url
 
    buffer = open(bitly_url, "UserAgent" => "Ruby-ExpandLink").read
    result = JSON.parse(buffer)
    #byebug
    short_url = result["results"][urlc]["shortUrl"]
  
    puts "###### Bitly ##############", short_url,result, buffer

    short_url
  end

  def pageranking(urlp)
    puts "################ pageranking ##############"
    require 'page_rankr'
    
    #urlp = "www.google.com"
    
    pr = PageRankr.ranks(urlp, :google)
    p = pr[:google]
    
    puts 
    puts "## pageranking #####", "urlp:", urlp, "p:", p, "pr:", pr
    p
  end

##############################################################

end

