# cdhistory

#### change to a previous used directory of your choice by using the command: ####
	cdh

### Functionality ###
The script shows you an option list of all absolute paths that are in your bash history.
After giving the option, the scripts changes directory to that path.

So very handy when you don't know the exact path or maybe projectname anymore and want to go quickly to that location.

### Usage ###
#### Adding to your $PATH variable ####
Make sure that the location of cdhistory.sh is in your $PATH variable. See: 'How to add a script to the $PATH variable'

#### Calling your script ####
You should call the script with the source command. So:
	$ source cdhistory.sh


### Setup as command: cdh ### 
for easier use you can setup a function in your ~/.bash_profile to call the script for you like this:
	cdh ()
	{
        	source cdhistory.sh
	}

Don't forget to source ~/.bash_profile after you've added the function.
	$ source ~/.bash_profile
#### Then using the script is as easy as: ####
	$ cdh




### How to add a script to the $PATH variable ###
If you don't know what you $PATH variable is. Open a commandline and 
	$ echo $PATH. 
Then you see all paths that are in this variable. If the file is in a directory that's in $PATH you can call it from every location in your system, so not only from the 
place wher it resides. 

If you want to put it in a directory that is not yet in $PATH but should be then that's possible by adding the following to your ~/.bash_profile
	export PATH=$PATH:~/To/My/Custom/Directory 
After adding, you should source your ~/.bash_profile:
	$ source ~/.bash_profile

