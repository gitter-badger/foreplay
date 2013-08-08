Feature: Setup
  In order to setup Foreplay
  As a CLI user
  I want to be able to create the config scaffold

  Scenario: Setup
	When I run `foreplay setup`
	Then the following files should exist:
		| config/foreplay.yml |
	And the file "config/foreplay.yml" should contain:
		"""
		# Format:
		#
		# There is a section for each environment that you will deploy to, plus a section that defines global default
		# values for all environments, like this:
		#
		# defaults:
		#   ...
		# production:
		#   ...
		# staging:
		#   ...
		#
		# Within each section you can define the server roles for that environment: web, worker, database etc. (the
		# names of these roles are up to you). You can also define environment-level defaults that apply to all roles.
		# Like this:
		#
		# production:
		#   defaults:
		#     ...
		#   web:
		#     ...
		#   worker:
		#     ...
		#   scheduler:
		#     ...
		#   database:
		#     ...
		# staging:
		#   defaults:
		#     ...
		#   web:
		#     ...
		#   worker:
		#     ...
		#   scheduler:
		#     ...
		#   database:
		#     ...
		#
		# Within each role section you can define how the deployment is configured for the servers in that role.
		# Some of these values will normally be defined as a default, some will be specific to a particular role.
		# The values you can configure are as follows:
		#
		# value         Normally defined as  Notes
		# ------------- -------------------- -------------------------------------------------------------------
		# name:         Global default       App name (if omitted then
		#                                    Rails.application.class.parent_name.underscore is used)
		# user:         Global default       The username to connect with (must have SSH permissions)
		# password:     Global default       The password to use to connect (not necessary if you've set up SSH
		#                                    keys - see below)
		# keyfile:      Global default       A file containing a private key that allows the named user access
		#                                    to the server, or...
		# key:          Global default       A private key that allows the named user access to the server
		# path:         Global default       An absolute path to deploy the app on each server. %a will be
		#                                    translated to the application name. %u will be translated to the
		#                                    login user name
		# database:     Environment default  The database.yml elements to write to the config folder
		#   key: value
		# servers: [server1, server2, server3]
		#               Role level           Which servers to deploy the app on
		# env:          Role level           Contents of the .env file
		#   key: value                       Values will go into the .env file as key=value
		# foreman:      Role level           Contents of the .foreman file
		#   key: value
		#
		defaults:
		  name: %q{TODO: Add the app name}
		  repository: %q{TODO: Add the git repository path}
		  user: %q{TODO: Add the user to logon to the deployment server}
		  password: %q{TODO: Add the password for the user on the deployment server}
		  path: %q{TODO: Add the path to deploy to on the deployment server}
		production:
		  defaults:
		    database:
		      adapter: postgresql
		      encoding: utf8
		      database: %q{TODO: Add the database name}
		      pool: 5
		      host: %q{TODO: Add the database host name}
		      username: %q{TODO: Add the database user}
		      password: %q{TODO: Add the database user's password}
		  web:
		    servers: [%q{TODO: Add the name of the production web server}]
		    foreman:
		      concurrency: 'web=1,worker=0,scheduler=0'
		"""
