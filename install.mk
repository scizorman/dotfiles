.DEFAULT_GOAL := install

.DELETE_ON_ERROR:
.INTERMEDIATE: get-poetry.py flutter.zip google-cloud-sdk.tar.gz

brew := /usr/local/bin/brew
$(brew):
	@bash -c '$(shell curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)'
	@brew bundle --global

zinit := $(HOME)/.zsh/.zinit
$(zinit):
	@git clone https://github.com/zdharma/zinit.git $@/bin

anyenv := $(HOME)/.anyenv
$(anyenv):
	@git clone https://github.com/anyenv/anyenv.git $@

sdkman := $(HOME)/.sdkman
$(sdkman):
	@curl -s 'https://get.sdkman.io?rcuupdate=false' | bash
	@source $@/bin/sdkman-init.sh

poetry := $(HOME)/.poetry
get-poetry.py:
	@curl -sSL 'https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py' -o $@
$(poetry): get-poetry.py
	@python $< --no-modify-path --yes

rustup := $(HOME)/.cargo/bin/rustup
$(rustup):
	@curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

flutter := $(HOME)/flutter
flutter.zip:
	@curl -sSL https://storage.googleapis.com/flutter_infra/releases/stable/macos/flutter_macos_1.22.4-stable.zip -o $@
$(flutter): flutter.zip
	@unzip $< -d $(@D)

google-cloud-sdk := $(HOME)/google-cloud-sdk
google-cloud-sdk.tar.gz:
	@curl -sSL https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-319.0.0-darwin-x86_64.tar.gz -o $@
$(google-cloud-sdk): google-cloud-sdk.tar.gz
	@tar zxvf $< -C $(@D)

install: $(brew) $(zinit) $(anyenv) $(poetry) $(rustup) $(flutter) $(google-cloud-sdk)

.PHONY: install
