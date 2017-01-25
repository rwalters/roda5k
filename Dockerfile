FROM base_build

RUN bundle install

CMD ruby app.rb -p 3000 -h 0.0.0.0
