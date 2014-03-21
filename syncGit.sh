rsync -ur --del --exclude=*.box --exclude=*.iso ~/packer/ ~/gits/myGit/packerVagrant/packer/
rsync -ur --del --exclude=*.box --exclude=*.iso ~/vagrant/ ~/gits/myGit/packerVagrant/vagrant/
rsync -ur --del --exclude=*.box --exclude=*.iso ~/gits/myGit/packerVagrant/packer/ ~/packer/
rsync -ur --del --exclude=*.box --exclude=*.iso ~/gits/myGit/packerVagrant/vagrant/ ~/vagrant/
