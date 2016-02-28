cwd                     = File.dirname(__FILE__)
log_level               :info   # valid values - :debug :info :warn :error :fatal
log_location            STDOUT
cookbook_path           File.expand_path(File.join(cwd,'..','cookbooks'))
node_path               File.expand_path(File.join(cwd,'..','nodes'))
