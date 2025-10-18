if [ ! -e '/check' ]; then
    echo "initializing..."
    apt update
    apt install -y build-essential 
    cd /srv/jekyll
    bundle install
    touch /check
fi
