class GitCommitController < ApplicationController
  include FileHandling

  def index

  end

  def create
      if !params[:dir_name].blank?
         @logs,@dirname,@branch = repo_commit(params[:dir_name])
      else
         @myurl = params[:user][:myurl]
         # @logarray = file_path(@myurl)
         logarray,@dirname,@branch = clone_repo(@myurl)
         @logs = logarray#.paginate(:page => params[:page], :per_page => 5)
      end
   end

   def repository
      @list = directory_list
   end

   def list_branches
     @branch_name = list_branch(params[:dir_name])
   end

   def change_branch
     change_repo_branch(params[:dir_name], params[:branch_name])
     redirect_to :action=>"create",:dir_name=>params[:dir_name]
   end
end
