class GitCommitController < ApplicationController
  include FileHandling

  def index
    
  end

  def create

      if !params[:dir_name].blank?
         @logs,@dirname =repo_commit(params[:dir_name])
      else
         @myurl = params[:user][:myurl]
         # @logarray = file_path(@myurl)
         logarray,@dirname = clone_repo(@myurl)
         #WillPaginate::Collection.create(1, 10, logarray.length)
         @logs = logarray#.paginate(:page => params[:page], :per_page => 30)
           
      end	

   end

   def repository
      @list = directory_list
   end
end
