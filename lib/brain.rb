# frozen_string_literal: true

require 'json'
require 'sinatra'
require 'sinatra/base'
require 'sinatra/config_file'
require 'redis'
require 'logger'

# Slapi Class - Primary Class
# Its main functions are to:
#  1. Set Sinatra Environment/Config
#     - configs loaded from ./config folder
#  2. Contains Required Endpoints for SLAPI
class Brain < Sinatra::Base
  set :root, File.dirname(__FILE__)
  register Sinatra::ConfigFile

  config_file '../environments.yml'
  config_file '../bot.yml'

  configure :production, :test, :development do
    enable :logging
  end

  # For future token assignments
  @headers = {}

  @logger = Logger.new(STDOUT)
  @logger.level = 'debug'

  @redis = Redis.new

  post '/query' do
    raise 'missing hash' unless params[:hash]
    begin
      if params[:key]
        body redis.hmget(params[:hash], params[:key])
        @logger.debug("Key retrieved for #{hash_name}")
      else
        body redis.hmget(params[:hash])
        @logger.debug("Hash retrieved for #{hash_name}")
      end
      status 200
    rescue => e
      status 500
      body "[ERROR] - Received #{e}"
      @logger.error("[ERROR] - Received #{e}")
    end
  end

  post '/delete' do
    raise 'missing channel' unless params[:hash]
    begin
      body @redis.hdel(hash_name, key)
      @logger.debug("Data deleted for #{hash_name}")
      status 200
    rescue => e
      status 500
      body "[ERROR] - Received #{e}"
      @logger.error("[ERROR] - Received #{e}")
    end
  end

  post '/save' do
    raise 'missing channel' unless params[:hash]
    begin
      body @redis.hmset(hash_name, key, value)
      @logger.debug("Data saved for #{hash_name}")
      status 200
    rescue => e
      status 500
      body "[ERROR] - Received #{e}"
      @logger.error("[ERROR] - Received #{e}")
    end
  end
end
