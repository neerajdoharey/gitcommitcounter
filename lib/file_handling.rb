module FileHandling
	def change_directory(dir_name="")
		cpath =  File.join(File.dirname(__FILE__),'..','tmp','gitrepo',dir_name)
		change_path=Dir.chdir(cpath)
	end
	def clone_repo(myurl)
	  	urlarray=@myurl.split("/")
	  	repo_dir=urlarray[-1].split(".")

	  	change_directory
	  	`git clone #{@myurl}`

	  	#logarray=repo_commit(repo_dir[0].to_s)
	  	Dir.chdir(repo_dir[0].to_s)
	  	log = `git log`
	  	logarray = log.split("commit")
		logarray.delete_at(0)

  		return hash_convert(logarray) ,repo_dir[0].to_s

	end

	def directory_list
		change_directory
		Dir.entries('.')
	end

	def repo_commit(dir_name)
		# cpath =  File.join(File.dirname(__FILE__),'..','tmp','gitrepo',"#{dir_name}")
		# change_path=Dir.chdir(cpath)
		change_directory(dir_name)
		log = `git log`
		branch = `git branch`
		special = "*"
		regex = /[#{special.gsub(/./){|char| "\\#{char}"}}]/
		curret_branch = branch.split("\n").select{ |i| i if i =~ regex }
  	logarray = log.split("commit")
		logarray.delete_at(0)
		return hash_convert(logarray) , dir_name, curret_branch[0]

	end

	def hash_convert(logarray)
		log_hash={}
		log_hash_array=[]
		logarray.each_with_index do |arr,id|
			commit=arr.split("Author:")
			author=commit[1].to_s.split("Date:")
			dat=author[1].to_s.split("\n\n")
			comment= dat[1].to_s.split("\n")

			log_hash["id"]=id+1
			log_hash["commit"]=commit[0]
			log_hash["author"]=author[0]
			log_hash["time"]=dat[0]#dat.nil? ? dat[0] : Date.parse(dat[0])
			log_hash["comment"]=comment.join("|")
			log_hash_array<<log_hash.clone
		end
		return log_hash_array
	end

	def list_branch(branch_dir)
		# cpath =  File.join(File.dirname(__FILE__),'..','tmp','gitrepo',branch_dir)
		# change_path=Dir.chdir(cpath)
		change_directory(branch_dir)
		branches = `git branch -r`
		branch_names =  branches.split("\n")
		puts branch_names.inspect
		return branch_names
	end

	def change_repo_branch(branch_dir ,branch_name)
		# cpath =  File.join(File.dirname(__FILE__),'..','tmp','gitrepo',branch_dir)
		# change_path=Dir.chdir(cpath)
		change_directory(branch_dir)
		puts `git branch`
		puts `git checkout #{branch_name}`
	end
end
