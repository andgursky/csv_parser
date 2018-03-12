web: bundle exec puma  -p $PORT
resque: QUEUE=* COUNT=5 VVERBOSE=1 bundle exec rake resque:workers
scheduler:  bundle exec rake environment resque:scheduler
