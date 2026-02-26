# syntax=docker/dockerfile:1
# Development-only Dockerfile for local Rails environment
FROM ruby:3.4.7

# Install system dependencies
RUN apt-get update -qq \
  && apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    sqlite3 \
    libsqlite3-dev \
    imagemagick \
    curl \
    git \
    ca-certificates \
    nodejs \
    npm \
    netcat-openbsd \
  && rm -rf /var/lib/apt/lists/*

# Use npm to install yarn (corepack may not be available in this base image)
RUN npm install -g yarn || true

ENV RAILS_ROOT=/app
WORKDIR $RAILS_ROOT

# 🔥 Cache and install gems (with optimization)
COPY Gemfile Gemfile.lock* ./
RUN gem install bundler || true
RUN bundle config set --local path 'vendor/bundle' \
  && bundle install --jobs 4 --retry 3 \
  && rm -rf ~/.bundle/ vendor/bundle/ruby/*/cache \
  && bundle exec bootsnap precompile --gemfile || true

# Copy the rest of the app
COPY . .

# Create tmp/pids so Rails can write PID file
RUN mkdir -p tmp/pids

# 🔥 Precompile bootsnap for faster Rails boot
RUN bundle exec bootsnap precompile app/ lib/ || true

# Add entrypoint
COPY entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

EXPOSE 3000

ENTRYPOINT ["/usr/bin/entrypoint.sh"]
CMD ["bin/dev"]
