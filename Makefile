gh-install:
	type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)
	curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
	&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
	&& echo "deb [arch=$$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
	&& sudo apt update \
	&& sudo apt install gh -y

gh-auth:
	gh auth login --with-token -p https
	gh auth status
	gh auth setup-git

git-conf:
	git config --global user.email saltshop.ryo408@gmail.com
	git config --global user.name shio408

git-init:
	git init
	git branch -M main
	git remote add origin https://github.com/shio408/isucon14.git

build:
	cd ~/webapp/go && go build -o isupipe .

deploy:
	make build
	sudo systemctl disable --now isupipe-go.service
	sudo systemctl enable --now isupipe-go.service
