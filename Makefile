#==============================================================================#
#                                  MAKE CONFIG                                 #
#==============================================================================#

MAKE	= make --no-print-directory -C
SHELL	:= bash --rcfile ~/.bashrc

#==============================================================================#
#                                     NAMES                                    #
#==============================================================================#

NAME = zDev_projects
VENV = .venv

### Message Vars
_SUCCESS 		= [$(GRN)SUCCESS$(D)]
_INFO 			= [$(BLU)INFO$(D)]
_NORM_SUCCESS 	= $(GRN)=== OK:$(D)
_NORM_INFO 		= $(BLU)File no:$(D)
_NORM_ERR 		= $(RED)=== KO:$(D)
_SEP 			= =====================

#==============================================================================#
#                                COMMANDS                                      #
#==============================================================================#

### Core Utils
RM		= rm -rf
MKDIR_P	= mkdir -p

#==============================================================================#
#                                  RULES                                       #
#==============================================================================#

##@ Project Scaffolding 󰛵

all: 	## Build environment
	make run

build:
	@echo "*** $(YEL)Building $(MAG)$(NAME)$(YEL) environment...$(D)"
	./scripts/build.sh
	@echo "* $(MAG)$(NAME) $(YEL)build$(D): $(_SUCCESS)"

run: build  # Run project
	@echo "* $(MAG)$(NAME) $(YEL)executing$(D): $(_SUCCESS)"
	source ./scripts/run.sh && python3 app.py
	@echo "* $(MAG)$(NAME) $(YEL)finished$(D): $(_SUCCESS)"

##@ Debug Rules 

posting:	# 
	posting "--collection $(NAME)postings --env .env"

serve: build  # Serve Textual project as a web app
	@echo "* $(YEL)Preparing to serve $(MAG)$(NAME)$(D):"
	textual serve $(APP)

console: build  # Serve Textual project as a console app
	@echo "* $(YEL)Preparing execute w/ console $(MAG)$(NAME)$(D):"

	tmux split-window -v "source .venv/bin/activate && textual console" 
	tmux resize-pane -U 30
	# tmux split-window -v "source .venv/bin/activate && textual run --dev $(APP)"
	source .venv/bin/activate && textual run --dev $(APP)

##@ Clean-up Rules 󰃢

clean: 				## Remove object files
	@echo "*** $(YEL)Removing $(MAG)$(NAME)$(D) and deps $(YEL)object files$(D)"
	@if [ -d "$(VENV)" ]; then \
		if [ -d "$(VENV)" ]; then \
			$(RM) $(VENV); \
			$(RM) *.sqlite; \
			$(RM) "app/__pycache__"; \
			$(RM) "app/LookinSlack.egg-info"; \
			echo "*** $(YEL)Removing $(CYA)$(BUILD_PATH)$(D) folder & files$(D): $(_SUCCESS)"; \
		fi; \
	else \
		echo " $(RED)$(D) [$(GRN)Nothing to clean!$(D)]"; \
	fi

##@ Help 󰛵

help: 			## Display this help page
	@awk 'BEGIN {FS = ":.*##"; \
			printf "\n=> Usage:\n\tmake $(GRN)<target>$(D)\n"} \
		/^[a-zA-Z_0-9-]+:.*?##/ { \
			printf "\t$(GRN)%-18s$(D) %s\n", $$1, $$2 } \
		/^##@/ { \
			printf "\n=> %s\n", substr($$0, 5) } ' Makefile
## Tweaked from source:
### https://www.padok.fr/en/blog/beautiful-makefile-awk

.PHONY: create_venv source_venv

#==============================================================================#
#                                  UTILS                                       #
#==============================================================================#

# Colors
#
# Run the following command to get list of available colors
# bash -c 'for c in {0..255}; do tput setaf $c; tput setaf $c | cat -v; echo =$c; done'
#
B  		= $(shell tput bold)
BLA		= $(shell tput setaf 0)
RED		= $(shell tput setaf 1)
GRN		= $(shell tput setaf 2)
YEL		= $(shell tput setaf 3)
BLU		= $(shell tput setaf 4)
MAG		= $(shell tput setaf 5)
CYA		= $(shell tput setaf 6)
WHI		= $(shell tput setaf 7)
GRE		= $(shell tput setaf 8)
BRED 	= $(shell tput setaf 9)
BGRN	= $(shell tput setaf 10)
BYEL	= $(shell tput setaf 11)
BBLU	= $(shell tput setaf 12)
BMAG	= $(shell tput setaf 13)
BCYA	= $(shell tput setaf 14)
BWHI	= $(shell tput setaf 15)
D 		= $(shell tput sgr0)
BEL 	= $(shell tput bel)
CLR 	= $(shell tput el 1)

