# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

import_config "compile/assets.exs"
import_config "compile/database.exs"
import_config "compile/endpoint.exs"
import_config "compile/logger.exs"
import_config "compile/mailer.exs"
import_config "compile/phoenix.exs"
